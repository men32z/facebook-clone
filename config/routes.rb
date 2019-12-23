Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update, :index]
  resources :posts, only: [:create]
  resources :comments, only: [:create]
  resources :likes, only: [:create]
  resources :friendships, only: [:index, :update, :create, :destroy]
  root to: 'pages#index'
end
