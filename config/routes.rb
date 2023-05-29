Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :users, only: [:create]
  resources :items, only: [:new, :create]
end
