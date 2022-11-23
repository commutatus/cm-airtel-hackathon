# frozen_string_literal: true

class ChatResponse < ApplicationRecord
  belongs_to :chatbot_session

  after_create :send_reply

  private

  def send_reply
    WhatsappMessage.new(self).send_message
  end
end
