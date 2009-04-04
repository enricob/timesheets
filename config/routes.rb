ActionController::Routing::Routes.draw do |map|
  map.resource :account, :controller => "users"
  map.resources :users

  map.resource :user_session, :as => "session", :except => "edit"
  map.root :controller => "user_sessions", :action => "new"
  
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
