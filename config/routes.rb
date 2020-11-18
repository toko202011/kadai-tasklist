Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  # get 'toppages/index'  root to: 'tasks#index'に変更
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'
  
  get 'signup', to: 'users#new'

  resources :tasks
  resources :users, only: [:index, :new, :create]
end
