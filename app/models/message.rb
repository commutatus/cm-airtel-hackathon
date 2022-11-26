# frozen_string_literal: true

class Message < ApplicationRecord
  enum message_type: {
    inbound: 0,
    outbound: 1
  }

  enum status: {
    ack: 0,
    received: 1,
    initiated: 2,
    sent: 3,
    read: 4
  }

  enum sentiment: {
      positive: 1,
      negative: 2,
      neutral: 3
  }

  belongs_to :intent, optional: true
  belongs_to :chatbot, optional: true

  after_commit :reply_message, if: ->(obj) { obj.inbound? && obj.saved_change_to_status? && obj.ack? }

  def reply_message
    SetupBotSession.new(self).send_message
  end
end
