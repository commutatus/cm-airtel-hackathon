class Response < ApplicationRecord
  include CmAdmin::Response
  belongs_to :intent
end
