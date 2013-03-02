Wmapps::Application.routes.draw do
  resources :users, :execpt => [:destroy, :edit]
  resources :sessions, :only => [:new, :create, :destroy]

  match '/login',   :to => 'sessions#new'
  match '/logout',  :to => 'sessions#destroy', via: :delete
  match '/signup',  :to => 'users#new'
end
