require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectsController do

  def mock_project(stubs={})
    @mock_project ||= mock_model(Project, stubs)
  end
  
  describe "GET index" do

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

  describe "GET show" do

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

  describe "GET new" do
  
    it "exposes a new project as @project" do
      Project.should_receive(:new).and_return(mock_project)
      get :new
      assigns[:project].should equal(mock_project)
    end

  end

  describe "GET edit" do
  
    it "exposes the requested project as @project" do
      Project.should_receive(:find).with("37").and_return(mock_project)
      get :edit, :id => "37"
      assigns[:project].should equal(mock_project)
    end

  end

  describe "POST create" do

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

  describe "PUT udpate" do

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

  describe "DELETE destroy" do

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

end
