# frozen_string_literal: true

class SetupBotSession
  def initialize(event)
    @event = event
    @session_client = Aws::LexRuntimeV2::Client.new(region: 'ap-southeast-1')
    # @bot_client = Aws::LexModelBuildingService::Client.new(region: 'ap-southeast-1')
    @chatbot = fetch_bot
  end

  #send message
  def send_message
    session = initialize_session
    recognize_text(session.session_id) if session.present?
  end

  #create a new session if there is no available session present
  def new_session
    unless @chat_session.present?
      @chat_session = ChatbotSession.create(from: @event.payload['from'], to: @event.payload['to'],
                                            started_at: Time.now, session_id: rand.to_s[2..16], chatbot_id: @chatbot.id)
    end
    @session_client.put_session({
                                  bot_id: @chatbot.bot_id,
                                  bot_alias_id: @chatbot.bot_alias_id,
                                  locale_id: @chatbot.locale_id,
                                  session_id: @chat_session.session_id,
                                  session_state: {
                                    dialog_action: {
                                      type: 'Delegate'
                                    },
                                    intent: {
                                      name: 'FallbackIntent', # fetch the proper intent in here
                                      state: 'ReadyForFulfillment'
                                    }
                                  }
                                })
  end

  def fetch_bot
    Chatbot.find_by(phone_number: @event.payload['to'])
  end

  # send text message to initiated session
  def recognize_text(session_id)
    response = @session_client.recognize_text({
                                                bot_id: @chatbot.bot_id, # required
                                                bot_alias_id: @chatbot.bot_alias_id, # required
                                                locale_id: @chatbot.locale_id, # required
                                                session_id:, # required
                                                text: @event.payload.dig('message', 'text', 'body') # required
                                              })
    @chat_session.update(last_message_at: Time.now)
    ChatResponse.create(response: response.to_h, chatbot_session_id: @chat_session.id)
  end

  def initialize_session
    return if @chatbot.nil?

    @chat_session = fetch_session
    get_lex_session
  end

  #chatbot session in db
  def fetch_session
    ChatbotSession.where(from: @event.payload['from'], to: @event.payload['to'], ended_at: nil,
                         chatbot_id: @chatbot.id).last
  end

  def get_lex_session
    @session_client.get_session({
                                  bot_id: @chatbot.bot_id, # required
                                  bot_alias_id: @chatbot.bot_alias_id, # required
                                  locale_id: @chatbot.locale_id, # required
                                  session_id: @chat_session.session_id # required
                                })
  rescue StandardError => e
    new_session
  end
end
