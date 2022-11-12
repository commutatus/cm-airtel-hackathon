class Intent < ApplicationRecord
  belongs_to :user
  belongs_to :chatbot
  has_many :utterances
end
