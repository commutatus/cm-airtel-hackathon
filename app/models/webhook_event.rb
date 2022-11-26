# frozen_string_literal: true

class WebhookEvent < ApplicationRecord
  after_create :update_message_entry, unless: proc { business_id.present? }

  private

  def update_message_entry
    message_entry = Message.find_or_create_by(message_id: payload['messageId'])
    message_entry.update(from: payload['sourceAddress'],
                                    to: payload['recipientAddress'],
                                    status: payload['msgStatus'].underscore,
                                    text: payload.dig('messageParameters', 'text',
                                                      'body').presence || message_entry.text,
                                    session_id: payload['sessionId'],
                                    message_type: payload['msgStream'].underscore)
  end
end
