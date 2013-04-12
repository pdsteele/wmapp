Wmapps::Application.routes.draw do

   devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :worker, :only => [:edit, :update, :show]
  resources :workorders
  
  root :to => 'pages#home'

  match '/login',   :to => 'sessions#new'
  match '/logout',  :to => 'sessions#destroy', via: :delete
  match '/signup',  :to => 'users#new'
  match '/assigned_workorders', :to => 'worker#show_assigned'
  match '/progress_workorders', :to => 'worker#show_in_progress'
  #match '/clients/:status' => 'clients#index', :foo => "bar" 
end


