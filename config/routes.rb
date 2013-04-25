Wmapps::Application.routes.draw do
  
  root :to => 'pages#home'
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :users do
    member do
      get  'completed_workorders'
    end
  end

  resources :sessions, :only => [:new, :create, :destroy]

  resources :worker, :only => [:edit, :update, :show] do
    member do
      get  'completed_workorders'
    end
  end

  resources :workorders do
    member do
      put 'set_review_and_close' # routing for the close method
    end

    resources :worklogs
  end


  match '/login',   :to => 'sessions#new'
  match '/logout',  :to => 'sessions#destroy', via: :delete
  match '/signup',  :to => 'users#new'
  match '/assigned_workorders', :to => 'worker#show_assigned'
  match '/progress_workorders', :to => 'worker#show_in_progress'
  
  #match '/deferral', :to => 'worker#show_deferral_form'
  
  #match '/accepted_workorder', :to => 'worker#show_accepted_workorder'
  #match '/deferred_workorder', :to => 'worker#show_deferred_workorder'

  match '/admin/workorders/:id/respond_to_comment/:worklog_id(.:format)', :to => 'admin/workorders#respond_to_comment', :as => 'respond_to_comment'
  match '/admin/workorders/:id/close_workorder/', :to => 'admin/workorders#close_workorder', :as => 'close_workorder'


  match '/workorder_review', :to => 'users#show_workorder_review'

  #match '/completed_workorders', :to => 'users#show_completed'




end


