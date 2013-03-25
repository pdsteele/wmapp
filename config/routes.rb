Wmapps::Application.routes.draw do
  resources :users, :except => [:destroy, :edit]
  resources :sessions, :only => [:new, :create, :destroy]

  root :to => 'pages#home'

  match '/login',   :to => 'sessions#new'
  match '/logout',  :to => 'sessions#destroy', via: :delete
  match '/signup',  :to => 'users#new'
end
