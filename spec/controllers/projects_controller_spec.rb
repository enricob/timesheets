require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'authlogic/test_case'

describe ProjectsController do
  dataset :users
  
  before(:each) do
    activate_authlogic
  end
  
  def mock_activity_type(stubs={})
    @mock_activity_type ||= mock_model(ActivityType, stubs)
  end

  def mock_project(stubs={})
    @mock_project ||= mock_model(Project, stubs)
  end
  
  describe "GET index" do 
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
      end
    
      it "exposes all projects as @projects" do
        Project.should_receive(:find).with(:all).and_return([mock_project])
        get :index
        assigns[:projects].should == [mock_project]
      end

      describe "with mime type of xml" do
        it "renders all projects as xml" do
          Project.should_receive(:find).with(:all).and_return(projects = mock("Array of Projects"))
          projects.should_receive(:to_xml).and_return("generated XML")
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

      it "exposes the requested project as @project" do
        Project.should_receive(:find).with("37").and_return(mock_project)
        get :show, :id => "37"
        assigns[:project].should equal(mock_project)
      end
    
      describe "with mime type of xml" do
        it "renders the requested project as xml" do
          Project.should_receive(:find).with("37").and_return(mock_project)
          mock_project.should_receive(:to_xml).and_return("generated XML")
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
    
      it "exposes a new project as @project with a blank activity type" do
        Project.should_receive(:new).and_return(mock_project)
        mock_project.should_receive(:activity_types).and_return(mock_array = [])
        mock_array.should_receive(:build).and_return(mock_activity_type)
        get :new
        assigns[:project].should equal(mock_project)
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
  
      it "exposes the requested project as @project" do
        Project.should_receive(:find).with("37").and_return(mock_project)
        get :edit, :id => "37"
        assigns[:project].should equal(mock_project)
      end
    end
    
    describe "with no logged in user" do
      it "redirects to login page" do
        get :edit, :id => "37"
        response.should redirect_to(new_user_session_url)
      end
    end
  end
  
  describe "GET activities_select" do
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
        @form_id = "my_form_id"
        @form_name = "my_form_name"
      end
      
      it "exposes the selected project as @project" do
        Project.should_receive(:find).with("37").and_return(mock_project)
        get :activities_select, :project_id => "37", :form_id => @form_id, :form_name => @form_name
        assigns[:project].should equal(mock_project)
      end
      
      it "exposes form_id as @form_id" do
        Project.should_receive(:find).with("37").and_return(mock_project)
        get :activities_select, :project_id => "37", :form_id => @form_id, :form_name => @form_name
        assigns[:form_id].should == @form_id
      end
      
      it "exposes form_name as @form_name" do
        Project.should_receive(:find).with("37").and_return(mock_project)
        get :activities_select, :project_id => "37", :form_id => @form_id, :form_name => @form_name
        assigns[:form_name].should == @form_name
      end
    end
    
    describe "with no logged in user" do
      it "redirects to the login page" do
        get :activities_select, :project_id => "37", :form_id => @form_id, :form_name => @form_name
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "POST create" do
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:zack))
      end

      describe "with valid params" do
        it "exposes a newly created project as @project" do
          Project.should_receive(:new).with({'these' => 'params'}).and_return(mock_project(:save => true))
          post :create, :project => {:these => 'params'}
          assigns(:project).should equal(mock_project)
        end

        it "redirects to the created project" do
          Project.stub!(:new).and_return(mock_project(:save => true))
          post :create, :project => {}
          response.should redirect_to(project_url(mock_project))
        end
      end
    
      describe "with invalid params" do
        it "exposes a newly created but unsaved project as @project" do
          Project.stub!(:new).with({'these' => 'params'}).and_return(mock_project(:save => false))
          post :create, :project => {:these => 'params'}
          assigns(:project).should equal(mock_project)
        end

        it "re-renders the 'new' template" do
          Project.stub!(:new).and_return(mock_project(:save => false))
          post :create, :project => {}
          response.should render_template('new')
        end
      end
    end
    
    describe "with no logged in user" do
      it "redirects to login page" do
        post :create, :project => {:these => 'params'}
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "PUT update" do
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
      end

      describe "with valid params" do
        it "updates the requested project" do
          Project.should_receive(:find).with("37").and_return(mock_project)
          mock_project.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :project => {:these => 'params'}
        end

        it "exposes the requested project as @project" do
          Project.stub!(:find).and_return(mock_project(:update_attributes => true))
          put :update, :id => "1"
          assigns(:project).should equal(mock_project)
        end

        it "redirects to the project" do
          Project.stub!(:find).and_return(mock_project(:update_attributes => true))
          put :update, :id => "1"
          response.should redirect_to(project_url(mock_project))
        end
      end
    
      describe "with invalid params" do
        it "updates the requested project" do
          Project.should_receive(:find).with("37").and_return(mock_project)
          mock_project.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :project => {:these => 'params'}
        end

        it "exposes the project as @project" do
          Project.stub!(:find).and_return(mock_project(:update_attributes => false))
          put :update, :id => "1"
          assigns(:project).should equal(mock_project)
        end

        it "re-renders the 'edit' template" do
          Project.stub!(:find).and_return(mock_project(:update_attributes => false))
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
        UserSession.create(users(:zack))
      end

      it "destroys the requested project" do
        Project.should_receive(:find).with("37").and_return(mock_project)
        mock_project.should_receive(:destroy)
        delete :destroy, :id => "37"
      end
  
      it "redirects to the projects list" do
        Project.stub!(:find).and_return(mock_project(:destroy => true))
        delete :destroy, :id => "1"
        response.should redirect_to(projects_url)
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
