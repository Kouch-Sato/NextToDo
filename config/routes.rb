Rails.application.routes.draw do

  namespace :user do
    get 'groups/index'
  end

  namespace :user do
    get 'groups/create'
  end

  namespace :user do
    get 'groups/edit'
  end

  namespace :user do
    get 'groups/destroy'
  end

  post "login" => "users#login"
  post "logout" => "users#logout"
  get "login" => "users#login_form"

  namespace :admin do
    resources :users do
    end  
  end

  namespace :user do
    get "tasks_for_calendar", to: "tasks#tasks"
    get "tasks/calendar"
    get "tasks/graph"
    resources :tasks do 
      patch :sort
    end
    resources :group
  end  

  resources :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
