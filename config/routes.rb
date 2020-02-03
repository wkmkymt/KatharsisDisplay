Rails.application.routes.draw do
  # Root
  root to: 'app#index'

  # Profile
  get 'users/:user_id', to: 'users#show', as: 'profile'
  post 'checkio', to: 'users#checkio', as: 'checkio'

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
