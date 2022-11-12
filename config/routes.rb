Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  post "/webhooks/process/:webhook_source", controller: :webhooks, action: :process

end
