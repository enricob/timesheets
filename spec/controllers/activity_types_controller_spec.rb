require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'authlogic/test_case'

describe ActivityTypesController do
  dataset :users
  
  before(:each) do
    activate_authlogic
  end

  def mock_activity_type(stubs={})
    @mock_activity_type ||= mock_model(ActivityType, stubs)
  end
  
  describe "GET index" do 
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
      end
    
      it "exposes all activity types as @activity_types" do
        ActivityType.should_receive(:find).with(:all).and_return([mock_activity_type])
        get :index
        assigns[:activity_types].should == [mock_activity_type]
      end

      describe "with mime type of xml" do
        it "renders all activity types as xml" do
          ActivityType.should_receive(:find).with(:all).and_return(activity_types = mock("Array of ActivityTypes"))
          activity_types.should_receive(:to_xml).and_return("generated XML")
          get :index, :format => 'xml'
          response.body.should == "generated XML"
        end
      end
    end
    
    describe "with no logged in user" do
      it "redirects to login page" do
        get :index
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "GET show" do
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:zack))
      end

      it "exposes the requested activity type as @activity_type" do
        ActivityType.should_receive(:find).with("37").and_return(mock_activity_type)
        get :show, :id => "37"
        assigns[:activity_type].should equal(mock_activity_type)
      end
    
      describe "with mime type of xml" do
        it "renders the requested activity type as xml" do
          ActivityType.should_receive(:find).with("37").and_return(mock_activity_type)
          mock_activity_type.should_receive(:to_xml).and_return("generated XML")
          get :show, :id => "37", :format => 'xml'
          response.body.should == "generated XML"
        end
      end
    end
    
    describe "with no logged in user" do
      it "redirects to login page" do
        get :show, :id => "37"
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "GET new" do
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
      end
    
      it "exposes a new activity type as @activity_type" do
        ActivityType.should_receive(:new).and_return(mock_activity_type)
        get :new
        assigns[:activity_type].should equal(mock_activity_type)
      end
    end
    
    describe "with no logged in user" do
      it "redirects to login page" do
        get :new
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "GET edit" do
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:zack))
      end
  
      it "exposes the requested activity type as @activity_type" do
        ActivityType.should_receive(:find).with("37").and_return(mock_activity_type)
        get :edit, :id => "37"
        assigns[:activity_type].should equal(mock_activity_type)
      end
    end
    
    describe "with no logged in user" do
      it "redirects to login page" do
        get :edit, :id => "37"
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "POST create" do
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
      end

      describe "with valid params" do
        it "exposes a newly created activity type as @activity_type" do
          ActivityType.should_receive(:new).with({'these' => 'params'}).and_return(mock_activity_type(:save => true))
          post :create, :activity_type => {:these => 'params'}
          assigns(:activity_type).should equal(mock_activity_type)
        end

        it "redirects to the created activity type" do
          ActivityType.stub!(:new).and_return(mock_activity_type(:save => true))
          post :create, :activity_type => {}
          response.should redirect_to(activity_type_url(mock_activity_type))
        end
      end
    
      describe "with invalid params" do
        it "exposes a newly created but unsaved activity_type as @activity_type" do
          ActivityType.stub!(:new).with({'these' => 'params'}).and_return(mock_activity_type(:save => false))
          post :create, :activity_type => {:these => 'params'}
          assigns(:activity_type).should equal(mock_activity_type)
        end

        it "re-renders the 'new' template" do
          ActivityType.stub!(:new).and_return(mock_activity_type(:save => false))
          post :create, :activity_type => {}
          response.should render_template('new')
        end
      end
    end
    
    describe "with no logged in user" do
      it "redirects to login page" do
        post :create, :activity_type => {:these => 'params'}
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "PUT update" do
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:zack))
      end

      describe "with valid params" do
        it "updates the requested activity type" do
          ActivityType.should_receive(:find).with("37").and_return(mock_activity_type)
          mock_activity_type.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :activity_type => {:these => 'params'}
        end

        it "exposes the requested activity type as @activity_type" do
          ActivityType.stub!(:find).and_return(mock_activity_type(:update_attributes => true))
          put :update, :id => "1"
          assigns(:activity_type).should equal(mock_activity_type)
        end

        it "redirects to the activity type" do
          ActivityType.stub!(:find).and_return(mock_activity_type(:update_attributes => true))
          put :update, :id => "1"
          response.should redirect_to(activity_type_url(mock_activity_type))
        end
      end
    
      describe "with invalid params" do
        it "updates the requested activity type" do
          ActivityType.should_receive(:find).with("37").and_return(mock_activity_type)
          mock_activity_type.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :activity_type => {:these => 'params'}
        end

        it "exposes the activity type as @activity_type" do
          ActivityType.stub!(:find).and_return(mock_activity_type(:update_attributes => false))
          put :update, :id => "1"
          assigns(:activity_type).should equal(mock_activity_type)
        end

        it "re-renders the 'edit' template" do
          ActivityType.stub!(:find).and_return(mock_activity_type(:update_attributes => false))
          put :update, :id => "1"
          response.should render_template('edit')
        end
      end
    end
    
    describe "with no logged in user" do
      it "redirects to login page" do
        put :update, :id => "1"
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "DELETE destroy" do
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
      end

      it "destroys the requested activity type" do
        ActivityType.should_receive(:find).with("37").and_return(mock_activity_type)
        mock_activity_type.should_receive(:destroy)
        delete :destroy, :id => "37"
      end
  
      it "redirects to the activity types list" do
        ActivityType.stub!(:find).and_return(mock_activity_type(:destroy => true))
        delete :destroy, :id => "1"
        response.should redirect_to(activity_types_url)
      end
    end
    
    describe "with no logged in user" do
      it "redirects to login page" do
        delete :destroy, :id => "1"
        response.should redirect_to(new_user_session_url)
      end
    end
  end
end
