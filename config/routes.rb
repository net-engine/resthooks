require 'sidekiq/web'

Resthooks::Application.routes.draw do
  root to: "landings#show"

  devise_for :users

  namespace :api, format: :json do
    namespace :v1 do
      resources :users, only: :index
      resources :beers, only: [:index, :create]
      resources :burgers, only: [:index, :create]
      resources :resource_subscriptions, only: [:index, :create]
    end
  end

  resource :landing, only: :show

  mount Sidekiq::Web => '/sidekiq'
end
