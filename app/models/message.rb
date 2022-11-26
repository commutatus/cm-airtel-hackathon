# frozen_string_literal: true

class Message < ApplicationRecord
  enum message_type: {
    inbound: 'inbound',
    outbound: 'outbound'
  }

  enum status: {
    ack: 'ack',
    received: 'received',
    initiated: 'initiated',
    sent: 'sent',
    read: 'read',
    failed: 'failed',
    delivered: 'delivered'
  }

  enum sentiment: {
    positive: 'positive',
    negative: 'negative',
    neutral: 'neutral'
  }

  belongs_to :intent, optional: true
  belongs_to :chatbot, optional: true

  after_commit :reply_message, if: -> (obj) { obj.inbound? && obj.saved_change_to_status? && obj.ack? }

  def reply_message
    SetupBotSession.new(self).send_message
  end
end
