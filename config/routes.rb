Rails.application.routes.draw do

  mount Spree::Core::Engine, :at => '/'

  namespace :api do
    namespace :v1 do
      resource :authorizations, only: :create
    end

  end

  Spree::Core::Engine.add_routes do
    namespace :api do
      resources :checkouts, only: [:create], format: 'json'
    end
  end
end

