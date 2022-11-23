# frozen_string_literal: true

module AwsLex::Utterance
  extend ActiveSupport::Concern

  included do
    after_commit :modify_utterance, on: [:create, :update, :destroy]
  end

  # Updates the sample utterances for an intent.
  def modify_utterance
    LexModelsV2::Intent.new(self.intent).update_intent
  end
end