# frozen_string_literal: true

module AwsLex::Response
  extend ActiveSupport::Concern

  included do
    after_commit :modify_response, on: [:create, :update, :destroy]
  end

  # Updates the success responses for an intent.
  def modify_response
    LexModelsV2::Intent.new(self.intent).update_intent
  end
end