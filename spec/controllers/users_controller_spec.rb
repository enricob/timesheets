require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'authlogic/test_case'

describe UsersController do
  #fixtures :users
  dataset :users
  
  before(:each) do
    activate_authlogic
  end
  
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end
  
  describe "GET new" do
    describe "for a logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
        get 'new'
      end
      
      it "redirects to the user's account" do
        response.should redirect_to("/account")
      end
      
      it "sets the flash" do
        assert flash[:notice] == "You must be logged out to access this page"
      end
    end
    
    describe "without a logged in user" do
      before(:each) do
        get 'new'
      end
      
      it "shows the sign-up form" do
        response.should render_template("users/new.html.erb")
      end
    end
  end
  
  describe "GET show" do
    describe "for a logged in user" do
      before(:each) do
        UserSession.create(users(:zack))
        get 'show'
      end
      
      it "shows the user's account info" do
        assert assigns[:user] == users(:zack)
        response.should render_template("users/show.html.erb")
      end
    end
    
    describe "with no logged in user" do
      before(:each) do
        get 'show'
      end
      
      it "redirects to the login page" do
        response.should redirect_to("/session/new")
      end
    end
  end
  
  describe "GET edit" do
    describe "for a logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
        get 'edit'
      end
      
      it "shows the account edit form for that user" do
        assert assigns[:user] == users(:ben)
        response.should render_template("users/edit.html.erb")
      end
    end
    
    describe "without a logged in user" do
      before(:each) do
        get 'edit'
      end
      
      it "redirects to the login page" do
        response.should redirect_to("/session/new")
      end
    end
  end
  
  describe "POST create" do
    describe "for a logged in user" do
      before(:each) do
        UserSession.create(users(:zack))
      end
      
      it "redirects to the user's account" do
        post 'create', :user => {'some' => 'params'}
        response.should redirect_to(account_path)
      end
      
      it "sets the flash" do
        post 'create', :user => {'some' => 'params'}
        flash[:notice].should == "You must be logged out to access this page"
      end
    end
    
    describe "without a logged in user" do
      describe "with valid params" do
        it "creates the user" do
          User.should_receive(:new).with({'some' => 'params'}).and_return(mock_user(:save => true))
          post 'create', :user => {'some' => "params"}
          assigns(:user).should equal(mock_user)
        end
      end
      
      describe "with invalid params" do
        it "exposes a newly created but unsaved user as @user" do
          User.should_receive(:new).with({'some' => 'params'}).and_return(mock_user(:save => false))
          post 'create', :user => {'some' => 'params'}
          assigns(:user).should equal(mock_user)
        end
        
        it "re-renders the 'new' template" do
          User.should_receive(:new).and_return(mock_user(:save => false))
          post 'create', :user => {}
          response.should render_template("users/new.html.erb")
        end
      end
    end
  end
  
  describe "PUT update" do
    describe "for a logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
      end
      
      describe "with valid attributes" do
        it "updates the logged in user" do
          put :update, :user => {}
          assigns(:user).should == users(:ben)
        end

        it "redirects to the user's account" do
          put :update, :user => {}
          response.should redirect_to(account_path)
        end
      end
      
      describe "with invalid attributes" do
        it "re-renders the 'edit' template" do
          put :update, :user => {:password => "pass", :password_confirmation => "wrong!"}
          response.should render_template("users/edit.html.erb")
        end
      end
    end
  end
end
