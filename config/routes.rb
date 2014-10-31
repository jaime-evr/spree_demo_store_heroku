Rails.application.routes.draw do

  mount Spree::Core::Engine, :at => '/'

  namespace :api do
    namespace :v1 do
      resource :authorizations, only: :create
    end

    resources :orders do
      member do
        put 'next_step'
      end
    end

  end

end

