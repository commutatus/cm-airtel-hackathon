class Chatbot < ApplicationRecord
  include CmAdmin::Chatbot
  belongs_to :user
  has_many :intents
  has_many :chatbot_sessions
end
