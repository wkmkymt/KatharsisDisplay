Rails.application.routes.draw do
  # Root
  root to: 'app#index'

  #Term of Service
  get 'tos', to: 'app#tos'

  #Privacy Policy
  get 'privacy', to: 'app#privacy'

  # Profile
  get 'users/:user_id', to: 'users#show', as: 'profile'

  # Display
  get 'display/:shop_id', to: 'users#display', as: 'display'

  # Review
  resources :reviews, only: [:create]

  # Contact
  resource :contact, only: [:show, :create]

  # Check In/Out
  get 'checkin/:user_id', to: 'users#checkin', as: 'checkin'
  get 'checkout/:user_id', to: 'users#checkout', as: 'checkout'
  get 'checkout_all', to: 'users#checkout_all', as: 'checkout_all'

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
      registrations: 'users/registrations',
      confirmations: 'users/confirmations',
      omniauth_callbacks: 'users/omniauth_callbacks',
    }

  # Profile Image
  resources :users do
    member do
      get 'show_profimg'
    end
  end

  # Admin
  ActiveAdmin.routes(self)

  # Web Mailer
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  # Exception
  get '*not_found', to: 'application#routing_error'
  post '*not_found', to: 'application#routing_error'
end
