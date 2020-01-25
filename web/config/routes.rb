Rails.application.routes.draw do
  devise_for :users
  # Root
  root to: "app#index"
end
