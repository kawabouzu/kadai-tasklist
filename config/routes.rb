Rails.application.routes.draw do
  root to: "tasks#index"
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:show, :new, :create, :destroy]
  resources :tasks, except: [:index]
end
