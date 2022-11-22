# frozen_string_literal: true

class Intent < ApplicationRecord
  include CmAdmin::Intent

  belongs_to :user
  belongs_to :chatbot
  has_many :utterances, dependent: :destroy
  has_many :responses, dependent: :destroy
end
