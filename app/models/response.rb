# frozen_string_literal: true

class Response < ApplicationRecord
  include CmAdmin::Response

  belongs_to :intent

  validate :max_limit_per_intent

  after_commit :modify_response, on: [:create, :update, :destroy]

  def max_limit_per_intent
    if intent.responses.size >= 3
      errors.add :less_than_or_equal_to_3, 'responses can be added per intent. Delete or edit the existing response(s).'
    end
  end

  # Updates the success responses for an intent.
  def modify_response
    LexModelsV2::Intent.new(self.intent).update_intent
  end
end
