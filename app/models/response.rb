# frozen_string_literal: true

class Response < ApplicationRecord
  include CmAdmin::Response

  belongs_to :intent

  validate :max_limit_per_intent

  def max_limit_per_intent
    if intent.responses.size >= 3
      errors.add :less_than_or_equal_to_3, 'responses can be added per intent. Delete or edit the existing response(s).'
    end
  end
end
