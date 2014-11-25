Rails.application.routes.draw do

  mount Spree::Core::Engine, :at => '/'

  namespace :api do
    namespace :v1 do
      resource :authorizations, only: :create
      get 'current_time', to: 'current_time#index'
    end
  end

  Spree::Core::Engine.add_routes do
    namespace :api do
      resources :orders do
        member do
          put 'next_state'
        end
        collection do
          get 'mine'
        end
      end
    end
  end

end

