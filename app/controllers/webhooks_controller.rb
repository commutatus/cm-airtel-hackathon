class WebhooksController < ApplicationController

  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  def process_webhook
    render body: nil, status: 200
  end
end
