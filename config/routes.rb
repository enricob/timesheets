ActionController::Routing::Routes.draw do |map|
  map.connect '/projects/:project_id/get_activities_select',
   :controller => "projects", :action => "get_activities_select"
  map.resources :projects

  map.resource :account, :controller => "users", :except => [:index, :destroy]
  map.resources :users, :except => [:index, :destroy]
  
  map.resources :timesheets
  map.connect '/timesheets/:year/:month/:day', :controller => "timesheets", :action => "edit"

  map.login '/login', :controller => "user_sessions", :action => "new"
  map.logout '/logout', :controller => "user_sessions", :action => "destroy"
  map.resource :user_session, :as => "session", :except => "edit"
  map.root :controller => "timesheets", :action => "index"
  
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
