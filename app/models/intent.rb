class Intent < ApplicationRecord
  belongs_to :user
  belongs_to :chatbot
  has_many :utterances
  has_many :responses
end
