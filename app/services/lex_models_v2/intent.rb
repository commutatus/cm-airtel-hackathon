# frozen_string_literal: true

module LexModelsV2
  class Intent
    def initialize(intent)
      @intent = intent
      @chatbot = @intent.chatbot
      @models_v2_client = Aws::LexModelsV2::Client.new(
        region: 'ap-southeast-1',
      )
    end

    # Creates an intent and store the intent_id.
    def create_intent
      resp = @models_v2_client.create_intent({
        bot_id: @chatbot.bot_id, # required
        bot_version: 'DRAFT', # required. Must be DRAFT
        locale_id: @chatbot.locale_id, # required
        intent_name: @intent.name, # required
        description: @intent.description,
      })

      @intent.update_column('intent_id', resp.intent_id)
      @chatbot.update_column('status', 'not_built')
    end

    # Updates the settings for an intent.
    def update_intent
      begin
        @models_v2_client.update_intent({
          bot_id: @chatbot.bot_id, # required
          bot_version: 'DRAFT', # required. Must be DRAFT
          locale_id: @chatbot.locale_id, # required
          intent_id: @intent.intent_id, # required
          intent_name: @intent.name, # required
          description: @intent.description,
          sample_utterances: generate_sample_utterances,
          fulfillment_code_hook: {
            enabled: false, # required
            active: true,
            post_fulfillment_status_specification: {
              success_response: generate_success_response,
              failure_response: {
                message_groups: [ # required
                  {
                    message: { # required
                      plain_text_message: {
                        value: 'Something went wrong.', # required
                      },
                    },
                    variations: [
                      {
                        plain_text_message: {
                          value: 'Please try again.', # required
                        },
                      },
                    ],
                  },
                ],
              },
            },
          },
        })

        @chatbot.update_column('status', 'not_built')
      rescue => exception
        puts exception
      end
    end

    # Removes the specified intent.
    def delete_intent
      begin
        @models_v2_client.delete_intent({
          intent_id: @intent.intent_id, # required
          bot_id: @chatbot.bot_id, # required
          bot_version: 'DRAFT', # required. Must be DRAFT
          locale_id: @chatbot.locale_id, # required
        })

        @chatbot.update_column('status', 'not_built')
      rescue => exception
        puts exception
      end
    end

    # Generate an array of hash for all the utterances that belongs to intent
    def generate_sample_utterances
      sample_utterances = []
      utterances = @intent.utterances.map(&:content)

      utterances.each do |value|
        sample_utterances << { utterance: value }
      end

      return sample_utterances
    end

    # Generate an array of hash for all the responses that belongs to intent
    def generate_success_response
      responses = ::Response.where(intent: @intent).map(&:content)

      return nil if responses.size.zero?

      variations = []
      responses.each do |response|
        variations << Hash.new.merge!({ plain_text_message: {
                                          value: response
                                        }
                                      })
      end

      message_groups = {}
      message_groups.merge!(message: variations.shift)
      message_groups.merge!(variations: variations) if variations.size > 0

      success_response = { message_groups: [message_groups] }

      return success_response
    end
  end
end