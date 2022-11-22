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

  # Creates an intent and store the intent_id.
  def create_intent
    client = Aws::LexModelsV2::Client.new(
      region: 'ap-southeast-1',
    )

    resp = client.create_intent({
      bot_id: chatbot.bot_id, # required
      bot_version: 'DRAFT', # required
      locale_id: chatbot.locale_id, # required
      intent_name: name, # required
      description: description,
    })

    update_column('intent_id', resp.intent_id)
  end
end
