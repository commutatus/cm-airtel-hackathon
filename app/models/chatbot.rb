class Chatbot < ApplicationRecord
  include CmAdmin::Chatbot
  belongs_to :user
  has_many :intents
  has_many :chatbot_sessions

  validates_format_of :name, with: /\A([a-zA-Z0-9_-]{1,100})\z/, message: 'can have maximum 100 characters. No space is allowed. Valid characters: A–Z, a–z, 0–9, -, _'
  validates_format_of :description, with: /\A(.{,200})\z/, message: 'can have maximum 200 characters.'

  after_create_commit :create_bot
  after_update_commit :update_bot
  before_destroy :delete_bot

  # Creates an Amazon Lex conversational bot and store the bot_id.
  def create_bot
    LexModelsV2.new(self).create_bot
  end

  # Updates the configuration of an existing bot.
  def update_bot
    arr = ['name', 'description']
    LexModelsV2.new(self).update_bot if (saved_changes.keys & arr).any?
  end

  # Deletes all versions of a bot
  def delete_bot
    LexModelsV2.new(self).delete_bot
  end
end