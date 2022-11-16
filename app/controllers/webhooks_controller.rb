class WebhooksController < ApplicationController

  def process(_webhook)
    webhook_source = params[:webhook_source]
    case webhook_source
    when 'airtel'
      creds = Rails.application.credentials.dig(:airtel)
      text = "#{creds.dig(:username)}:#{creds.dig(:password)}"
      computed = "Basic #{Base64.strict_encode64(text)}"
      signature = request.headers['Authorization']
      if Rack::Utils.secure_compare(computed, signature)
        response = JSON.parse(request.body.read).with_indifferent_access
        webhook_event = WebhookEvent.create(source: webhook_source,
                                            payload: response,
                                            session_id: response.dig('sessionId'),
                                            business_id: response.dig('businessId')
                                          )
        return render json: { success: true }.to_json, status: 200
      end
    end
    return render json: { success: false }.to_json, status: 404
  end
end
