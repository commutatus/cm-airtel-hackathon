# frozen_string_literal: true

class Response < ApplicationRecord
  include CmAdmin::Response

  belongs_to :intent
end
