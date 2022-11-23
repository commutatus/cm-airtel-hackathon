# frozen_string_literal: true

class Intent < ApplicationRecord
  include CmAdmin::Intent

  belongs_to :user
  belongs_to :chatbot
  has_many :utterances, dependent: :destroy
  has_many :responses, dependent: :destroy

  validates_format_of :name, with: /\A([a-zA-Z0-9_-]{1,100})\z/, message: 'can have maximum 100 characters. No space is allowed. Valid characters: A–Z, a–z, 0–9, -, _'
  validates_format_of :description, with: /\A(.{,200})\z/, message: 'can have maximum 200 characters.'

  after_create_commit :create_intent
  after_update_commit :update_intent
  before_destroy :delete_intent

  # Creates an intent and store the intent_id.
  def create_intent
    LexModelsV2::Intent.new(self).create_intent
  end

  # Updates the settings for an intent.
  def update_intent
    LexModelsV2::Intent.new(self).update_intent
  end

  # Removes the specified intent.
  def delete_intent
    LexModelsV2::Intent.new(self).delete_intent
  end
end
