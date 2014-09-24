Rails.application.routes.draw do

  mount Spree::Core::Engine, :at => '/'

  namespace :api do
    namespace :v1 do
      resource :authorizations, only: :create
    end

  end

end

