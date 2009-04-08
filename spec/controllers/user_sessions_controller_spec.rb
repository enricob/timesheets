require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'authlogic/test_case'

describe UserSessionsController do
  dataset :users
  
  before(:each) do
    activate_authlogic
  end
  
  describe "GET new" do
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
      end
      
      it "redirects to account page" do
        get 'new'
        response.should redirect_to(account_path)
      end
    end
    
    describe "with no logged in user" do
      it "renders login page" do
        get 'new'
        response.should render_template("user_sessions/new.html.erb")
      end
    end
  end
end
