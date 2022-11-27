# frozen_string_literal: true

class Chatbot < ApplicationRecord
  include CmAdmin::Chatbot
  include AwsLex::Chatbot

  belongs_to :user
  has_many :messages
  has_many :intents, dependent: :delete_all
  has_many :chatbot_sessions, dependent: :destroy

  validates_format_of :name, with: /\A([a-zA-Z0-9_-]{1,100})\z/, message: 'can have maximum 100 characters. No space is allowed. Valid characters: A–Z, a–z, 0–9, -, _'
  validates_format_of :description, with: /\A(.{,200})\z/, message: 'can have maximum 200 characters.'
  validates_format_of :phone_number, with: /\A([0-9]{10})\z/, message: 'should be of 10 digits.'
  validates_uniqueness_of :phone_number
end