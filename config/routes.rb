Rails.application.routes.draw do
  root to: 'tasks#index'

  get 'users/new'
  get 'users/create'
  # get 'toppages/index' 'tasks#index'のため不要
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'

  resources :tasks
  resources :users, only: [:index, :show, :new, :create]
end
