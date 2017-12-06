Rails.application.routes.draw do

  post "login" => "sessions#create"
  post "logout" => "sessions#destroy"
  get "login" => "sessions#new"

  get 'users/index'

  get 'home/top'

  resources :tasks
  resources :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
