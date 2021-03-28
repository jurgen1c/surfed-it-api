Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  devise_for :users,
    controllers: {
      confirmations: 'confirmations',
      passwords: 'passwords',
      registrations: 'registrations',
      sessions: 'sessions',
    }
  namespace :api do
    namespace :v1 do
          resources :locations do
            member do
              resources :surf_sessions
            end
          end
          resources :boards
    end
  end
=begin
  controllers: {
    confirmations: 'confirmations',
    passwords: 'passwords',
    registrations: 'registrations',
    sessions: 'sessions',
  }
=end

  # Ping to ensure site is up
  resources :ping, only: [:index] do
    collection do
      get :auth
    end
  end
end
