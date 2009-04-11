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
        get :new
        response.should redirect_to(account_path)
      end
      
      it "sets the flash" do
        post :create, :user_session => {}
        assert_equal flash[:notice], "You must be logged out to access this page"
      end
    end
    
    describe "with no logged in user" do
      it "renders login page" do
        get :new
        response.should render_template("user_sessions/new.html.erb")
      end
    end
  end
  
  describe "POST create" do
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:zack))
      end
      
      it "redirects to account page" do
        post :create, :user_session => {}
        response.should redirect_to(account_path)
      end
      
      it "sets the flash" do
        post :create, :user_session => {}
        assert_equal flash[:notice], "You must be logged out to access this page"
      end
    end
    
    describe "with no logged in user" do
      describe "and correct credentials" do
        it "creates the session" do
          post :create, :user_session => {:login => "ben", :password => "benrocks", :remember_me => "0"}
          assert_not_nil assigns(:user_session)
        end
        
        it "redirects to the timesheets index" do
          post :create, :user_session => {:login => "zack", :password => "zackrocks", :remember_me => "0"}
          response.should redirect_to(timesheets_path)
        end
      end
      describe "and incorrect credentials" do
        it "re-renders the login page" do
          test_creds = {:login => "baduser", :password => "badpass", :remember_me => "0"}
          post :create, :user_session => test_creds
          response.should render_template("user_sessions/new.html.erb")
        end
      end
      describe "and incomplete credentials" do
        it "re-renders the login page" do
          test_creds = {:login => "ben", :password => "", :remember_me => "0"}
          post :create, :user_session => test_creds
          response.should render_template("user_sessions/new.html.erb")
        end
      end
    end
  end
end
