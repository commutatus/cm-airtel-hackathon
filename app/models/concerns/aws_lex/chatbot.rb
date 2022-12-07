# frozen_string_literal: true

module AwsLex::Chatbot
  extend ActiveSupport::Concern

  included do
    after_create_commit :create_bot
    after_update_commit :update_bot
    before_destroy :delete_bot
  end

  # Creates an Amazon Lex conversational bot and store the bot_id.
  # Create built-in fallback intent.
  def create_bot
    LexModelsV2::Chatbot.new(self).create_bot
    self.intents.create(name: 'FallbackIntent',
                        description: 'Build-in fallback intent.',
                        intent_id: 'FALLBCKINT',
                        user_id: self.user_id,
                        intent_type: :built_in
                      )
  end

  # Updates the configuration of an existing bot.
  def update_bot
    arr = ['name', 'description']
    LexModelsV2::Chatbot.new(self).update_bot if (saved_changes.keys & arr).any?
  end

  # Deletes all versions of a bot
  def delete_bot
    LexModelsV2::Chatbot.new(self).delete_bot
  end

  # Build chatbot and update the status using waiter.
  def build
    LexModelsV2::Chatbot.new(self).build
  end
end