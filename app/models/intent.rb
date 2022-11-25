# frozen_string_literal: true

class Intent < ApplicationRecord
  include CmAdmin::Intent
  include AwsLex::Intent

  belongs_to :user
  belongs_to :chatbot
  has_many :utterances, dependent: :delete_all
  has_many :responses, dependent: :delete_all

  enum intent_type: {
    built_in: 'built_in',
    custom: 'custom'
  }

  validates :name, uniqueness: { scope: :chatbot_id }
  validates_format_of :name, with: /\A([a-zA-Z0-9_-]{1,100})\z/, message: 'can have maximum 100 characters. No space is allowed. Valid characters: A–Z, a–z, 0–9, -, _'
  validates_format_of :description, with: /\A(.{,200})\z/, message: 'can have maximum 200 characters.'

  before_destroy :check_intent_type

  def check_intent_type
    raise 'Built-in intent can\'t be deleted.'
  end
end