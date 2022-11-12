class Chatbot < ApplicationRecord
  belongs_to :user
  has_many :intents
end
