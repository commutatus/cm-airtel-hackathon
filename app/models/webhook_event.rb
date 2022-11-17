# frozen_string_literal: true

class WebhookEvent < ApplicationRecord
  after_create :setup_session, if: proc { business_id.present? }

  private

  def setup_session
    SetupBotSession.new(self).send_message
  end
end
