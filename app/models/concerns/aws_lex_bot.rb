# frozen_string_literal: true

module AwsLexBot
  extend ActiveSupport::Concern

  included do
    after_create_commit :create_bot
    after_update_commit :update_bot
    before_destroy :delete_bot
  end

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