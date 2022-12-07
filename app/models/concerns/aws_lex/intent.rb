# frozen_string_literal: true

module AwsLex::Intent
  extend ActiveSupport::Concern

  included do
    after_create_commit :create_intent
    after_update_commit :update_intent
    before_destroy :delete_intent
  end

  # Creates an intent and store the intent_id.
  def create_intent
    LexModelsV2::Intent.new(self).create_intent if self.custom?
  end

  # Updates the settings for an intent.
  def update_intent
    LexModelsV2::Intent.new(self).update_intent
  end

  # Removes the specified intent.
  def delete_intent
    throw(:abort) if built_in?
    LexModelsV2::Intent.new(self).delete_intent if self.custom?
  end
end