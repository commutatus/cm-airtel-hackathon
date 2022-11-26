# frozen_string_literal: true

namespace :generate_message_statistics do
  task create_messages: :environment do
    WebhookEvent.where(business_id: nil).each do |event|
      payload = event.payload

      next unless payload.present?

      message_entry = Message.find_or_create_by(message_id: payload['messageId'])
      message_status = payload['msgStream']&.underscore
      message_type = :outbound if message_status.eql?('outbound')
      message_entry.update(from: payload['sourceAddress'],
                           to: payload['recipientAddress'],
                           status: message_status,
                           text: payload.dig('messageParameters', 'text',
                                             'body').presence || message_entry.text,
                           session_id: payload['sessionId'],
                           message_type: message_type)
    end
    # to prevent triggering callback
    Message.where(message_type: nil).update_all(message_type: :inbound)
  end
end
