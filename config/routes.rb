Rails.application.routes.draw do

  mount Spree::Core::Engine, :at => '/'

  namespace :api do
    namespace :v1 do
      resource :authorizations, only: :create
    end
  end

  Spree::Core::Engine.add_routes do
    namespace :api do
      resources :orders do
        member do
          put 'next_state'
        end
      end
    end
  end

end

