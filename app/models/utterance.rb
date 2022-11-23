# frozen_string_literal: true

class Utterance < ApplicationRecord
  include CmAdmin::Utterance

  belongs_to :intent

  after_commit :modify_utterance, on: [:create, :update, :destroy]

  # Updates the sample utterances for an intent.
  def modify_utterance
    LexModelsV2::Intent.new(self.intent).update_intent
  end
end
