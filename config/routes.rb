Rails.application.routes.draw do

  root to: 'tasks#index'
  
  resources :tasks, only: [:index, :show, :create, :destroy, :edit, :update]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  
   get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
end