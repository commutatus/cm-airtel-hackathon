# frozen_string_literal: true

class Utterance < ApplicationRecord
  include CmAdmin::Utterance
  include AwsLex::Utterance

  belongs_to :intent
end
