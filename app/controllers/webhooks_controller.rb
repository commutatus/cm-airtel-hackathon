class WebhooksController < ApplicationController

  def process(_webhook)
    response = JSON.parse(request.body.read)
    webhook_event = WebhookEvent.create(source: params[:webhook_source],
                                        payload: response,
                                        session_id: response['sessionId'],
                                        business_id: response['businessId'])
  end
end
