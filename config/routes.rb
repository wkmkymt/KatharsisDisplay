Rails.application.routes.draw do
  get 'operations/ads_list', to: "operations#ads_list"
  get 'operations/users_list', to: "operations#users_list"
  # Root
  root to: "app#index"

  # Static Pages
  get "tos", to: "app#tos"
  get "privacy", to: "app#privacy"

  # Devise
  devise_for :users,
    path: "",
    path_names: {
      sign_in: "login",
      sign_out: "logout",
      registration: "signup",
      sign_up: "",
    },
    controllers: {
      sessions: "users/sessions",
      passwords: "users/passwords",
      registrations: "users/registrations",
      confirmations: "users/confirmations",
      omniauth_callbacks: "users/omniauth_callbacks",
    }

  # User
  resources :users, only: [:show, :destroy] do
    get "image", to: "users#show_image"
  end
  get "user/destroy_confirmation", to: "users#destroy_confirmation"

  # User Password
  resource :pass, only: [:new, :create, :edit, :update]

  # Advertisement Image
  resources :advertisements, only: [:index, :create, :destroy] do
    get "image", to: "advertisements#show_image"
  end

  # Display
  resources :displays, only: [:show]

  # Contact
  resource :contact, only: [:show, :create]

  # Review
  resource :review, only: [:create]

  # Checkin
  get "checkin/:id", to: "checkins#checkin", as: "checkin"
  get "checkout/:id", to: "checkins#checkout", as: "checkout"
  get "checkout_all", to: "checkins#checkout_all", as: "checkout_all"

  # Admin Pages
  ActiveAdmin.routes(self)

  # Web Mailer
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # Exception
  get "*not_found", to: "application#routing_error"
  post "*not_found", to: "application#routing_error"
end
