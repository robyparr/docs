Rails.application.routes.draw do
  root 'repositories#index'

  constraints subdomain: /.*/ do
    devise_for :users

    resources :repositories do
      resources :api_tokens, only: %i[create edit update destroy]
      resources :documents, only: %i[show]
    end

    namespace :api do
      resources :documents, only: %i[create]
    end
  end

  get '/public/:slug', to: 'public#show', as: :public_root
  get '/public/:slug/documents/:id', to: 'public/documents#show', as: :public_document

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
