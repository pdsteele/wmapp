Wmapps::Application.routes.draw do

   devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :worker, :only => [:edit, :update, :show]
  resources :workorders do
    resources :worklogs
  end
  
  root :to => 'pages#home'

  match '/login',   :to => 'sessions#new'
  match '/logout',  :to => 'sessions#destroy', via: :delete
  match '/signup',  :to => 'users#new'
  match '/assigned_workorders', :to => 'worker#show_assigned'
  match '/progress_workorders', :to => 'worker#show_in_progress'
  
  match '/deferral', :to => 'worker#show_deferral_form'
  
  match '/accepted_workorder', :to => 'worker#show_accepted_workorder'
  match '/deferred_workorder', :to => 'worker#show_deferred_workorder'
  
  #match '/clients/:status' => 'clients#index', :foo => "bar" 
end


