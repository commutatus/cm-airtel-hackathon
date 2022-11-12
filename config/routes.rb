Rails.application.routes.draw do
  devise_for :users
  mount CmAdmin::Engine => "/admin"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  post "/webhooks/process/:webhook_source", controller: :webhooks, action: :process
end
