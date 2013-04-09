Wmapps::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :workorders, only: [:create, :destroy]
  resources :worker, :only => [:edit, :update, :show]

  root :to => 'pages#home'

  match '/login',   :to => 'sessions#new'
  match '/logout',  :to => 'sessions#destroy', via: :delete
  match '/signup',  :to => 'users#new'
end
