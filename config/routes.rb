require 'sidekiq/web'

Resthooks::Application.routes.draw do
  namespace :api, format: :json do
    namespace :v1 do
      resources :users, only: :index
      resources :beers, only: [:index, :create]
      resources :burgers, only: [:index, :create]
      resources :resource_subscriptions, only: :index
    end
  end
  root to: "application#index"

  mount Sidekiq::Web => '/sidekiq'
end
