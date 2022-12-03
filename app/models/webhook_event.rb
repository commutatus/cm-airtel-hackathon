# frozen_string_literal: true

class WebhookEvent < ApplicationRecord
  after_create :update_message_entry, unless: proc { business_id.present? }

  private

  def update_message_entry
    message_entry = Message.find_or_create_by(message_id: payload['messageId'])
    whatsapp_business_number = case payload['msgStream']
                               when 'OUTBOUND'
                                 country_code = payload['sourceCountry'].split('+').last
                                 payload['sourceAddress'].split(country_code).last
                               when 'INBOUND'
                                 country_code = payload['recipientCountry'].split('+').last
                                 payload['recipientAddress'].split(country_code).last
                               end
    chatbot_id = Chatbot.find_by(phone_number: whatsapp_business_number).try(:id)
    message_entry.update(from: payload['sourceAddress'],
                                    to: payload['recipientAddress'],
                                    status: payload['msgStatus'].underscore,
                                    text: payload.dig('messageParameters', 'text',
                                                      'body').presence || message_entry.text,
                                    session_id: payload['sessionId'],
                                    message_type: payload['msgStream'].underscore,
                                    chatbot_id: chatbot_id)
  end
end
