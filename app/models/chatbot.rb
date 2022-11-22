# frozen_string_literal: true

class Chatbot < ApplicationRecord
  include CmAdmin::Chatbot
  include AwsLex::Chatbot

  belongs_to :user
  has_many :intents, dependent: :destroy
  has_many :chatbot_sessions, dependent: :destroy

  validates_format_of :name, with: /\A([a-zA-Z0-9_-]{1,100})\z/, message: 'can have maximum 100 characters. No space is allowed. Valid characters: A–Z, a–z, 0–9, -, _'
  validates_format_of :description, with: /\A(.{,200})\z/, message: 'can have maximum 200 characters.'
end