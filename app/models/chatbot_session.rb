# frozen_string_literal: true

class ChatbotSession < ApplicationRecord
  belongs_to :chatbot
  has_many :chat_responses
end
