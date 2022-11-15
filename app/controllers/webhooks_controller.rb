class WebhooksController < ApplicationController
  def process(webhook)
    # webhook_event_id was set not null true we can refactor it later
    webhook_event = WebhookEvent.create(source: params[:webhook_source], payload: request.body.read, webhook_event_id: rand(10))
  end
end
