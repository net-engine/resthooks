Resthooks::Application.routes.draw do
  namespace :api, format: :json do
    namespace :v1 do
      resources :users, only: :index
      resources :beers, only: :index
      resources :burgers, only: :index
    end
  end
  root to: "application#index"
end
