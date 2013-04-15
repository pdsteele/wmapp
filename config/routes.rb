Wmapps::Application.routes.draw do

   devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
#<<<<<<< HEAD
#<<<<<<< HEAD
#  resources :workorders, only: [:new, :create, :destroy]
#=======
#  resources :workorders, only: [:create, :destroy]
#  resources :worker, :only => [:edit, :update, :show]
#>>>>>>> 527ed5d1ed511ff278790c4b610f0c9b3967d150

#=======
  resources :worker, :only => [:edit, :update, :show]
  resources :workorders
  
#>>>>>>> 95d5e105a3aceed2a9f57b0e96ac11fb1dc68ce5
  root :to => 'pages#home'

  match '/login',   :to => 'sessions#new'
  match '/logout',  :to => 'sessions#destroy', via: :delete
  match '/signup',  :to => 'users#new'
  match '/assigned_workorders', :to => 'worker#show_assigned'
  match '/progress_workorders', :to => 'worker#show_in_progress'
  
  match '/deferral', :to => 'worker#show_deferral_form'
  
  match '/accepted_workorder', :to => 'worker#show_accepted_workorder'
  
  #match '/clients/:status' => 'clients#index', :foo => "bar" 
end


