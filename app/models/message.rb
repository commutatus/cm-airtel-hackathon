# frozen_string_literal: true

class Message < ApplicationRecord
  enum message_type: {
    'INBOUND' => 0,
    'OUBOUND' => 1
  }

  enum status: {
    'ACK' => 0,
    'RECEIVED' => 1,
    'INITIATED' => 2,
    'SENT' => 3,
    'READ' => 4
  }

  enum sentiment: {
      'POSITIVE': 1,
      'NEGATIVE': 2,
      'NEUTRAL': 3
  }

  after_commit :reply_message, if: ->(obj) { obj.message_type == 'INBOUND' && obj.saved_change_to_status? && obj.status == 'ACK' }

  def reply_message
    SetupBotSession.new(self).send_message
  end
end
