class Intent < ApplicationRecord
  include CmAdmin::Intent
  belongs_to :user
  belongs_to :chatbot
  has_many :utterances
  has_many :responses
end
