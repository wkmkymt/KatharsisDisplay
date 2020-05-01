Rails.application.routes.draw do
  # Root
  root to: 'app#index'

  #Term of Service
  get 'tos', to: 'app#tos'

  # Profile
  get 'users/:user_id', to: 'users#show', as: 'profile'

  # Display
  get 'display/:shop_id', to: 'users#display', as: 'display'

  # Review
  resources :reviews, only: [:create]

  # Check In/Out
  get 'checkin/:user_id', to: 'users#checkin', as: 'checkin'
  get 'checkout/:user_id', to: 'users#checkout', as: 'checkout'

  #Destroy
  get 'destroy_confirmation', to: 'users#destroy_confirmation', as: 'destroy_confirmation'
  get 'destroy', to: 'users#destroy', as: 'destroy'

  # Devise
  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup',
      sign_up: '',
    },
    controllers: {
      registrations: 'users/registrations'
    }

  # Profile Image
  resources :users do
    member do
      get 'show_profimg'
    end
  end

  # Admin
  ActiveAdmin.routes(self)
end
