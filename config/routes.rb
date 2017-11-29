Rails.application.routes.draw do

  get 'users/index'

  get 'home/top'

  resources :tasks, only: [:create, :destroy, :index, :update, :edit]
  resources :users, only: [:create, :destroy, :index, :update, :edit]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
