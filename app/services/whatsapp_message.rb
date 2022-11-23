# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

class WhatsappMessage
  AIRTEL_URL = 'https://iqwhatsapp.airtel.in:443/gateway/airtel-xchange/basic/whatsapp-manager/v1/session/'
  USERNAME = Rails.application.credentials.dig(:airtel_client, :username)
  PASSWORD = Rails.application.credentials.dig(:airtel_client, :password)

  def initialize(response)
    @bot_response = response
  end

  # Send message to whatsapp user based on the message content type
  def send_message
    @bot_response.response['messages'].each do |message|
      method(message['content_type'].underscore).call(message)
    end
  end

  def plain_text(message)
    bot_session = @bot_response.chatbot_session
    url = URI("#{AIRTEL_URL}send/text")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request['Content-Type'] = 'application/json'
    request['Authorization'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(USERNAME, PASSWORD)
    request.body = JSON.dump({
                               "sessionId": bot_session.session_id,
                               "to": bot_session.from,
                               "from": bot_session.to,
                               "message": {
                                 "text": message['content']
                               }
                             })

    response = https.request(request)
  end
end