class WebhooksController < ApplicationController

  def process(_webhook)
    response = JSON.parse(request.body).with_indifferent_access
    webhook_event = WebhookEvent.create(source: params[:webhook_source],
                                        payload: response,
                                        session_id: response.dig('sessionId'),
                                        business_id: response.dig('businessId'))
  end
end
