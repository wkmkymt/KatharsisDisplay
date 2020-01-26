Rails.application.routes.draw do
  # Root
  root to: 'app#index'

  # Devise
  devise_for :users,
    path: '', 
    path_names: { 
      sign_in: 'login', 
      sign_out: 'logout',
      registration: 'signup',
      sign_up: '',
    }
end
