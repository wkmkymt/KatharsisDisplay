Rails.application.routes.draw do
  # Root
  root to: 'app#index'

  # Profile
  get 'users/:user_id', to: 'users#show', as: 'profile'

  # Display
  get 'display', to: 'users#display', as: 'display'

  # Review
  resources :reviews, only: [:create]

  # Check In/Out
  get 'checkin/:user_id', to: 'users#checkin', as: 'checkin'
  get 'checkout/:user_id', to: 'users#checkout', as: 'checkout'

  # Devise
  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup',
      sign_up: '',
    }

  # Admin
  ActiveAdmin.routes(self)
end
