ActionController::Routing::Routes.draw do |map|
  map.resources :activity_types

  map.resources :projects

  map.resource :account, :controller => "users", :except => [:index, :destroy]
  map.resources :users, :except => [:index, :destroy]

  map.login '/login', :controller => "user_sessions", :action => "new"
  map.logout '/logout', :controller => "user_sessions", :action => "destroy"
  map.resource :user_session, :as => "session", :except => "edit"
  map.root :controller => "user_sessions", :action => "new"
  
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
