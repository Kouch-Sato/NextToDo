Rails.application.routes.draw do

  post "login" => "users#login"
  post "logout" => "users#logout"
  get "login" => "users#login_form"

  get 'home/top'

  namespace :admin do
    resources :users
  end

  namespace :user do
    resources :tasks
  end  

  resources :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
