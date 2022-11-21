# frozen_string_literal: true

class ChatResponse < ApplicationRecord
  belongs_to :chatbot_session
end
