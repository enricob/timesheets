require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'authlogic/test_case'

describe TimesheetsController do
  dataset :users, :timesheets
  
  before(:each) do
    activate_authlogic
  end
  
  def mock_timesheet(stubs={})
    @mock_timesheet ||= mock_model(Timesheet, stubs)
  end
  
  describe "GET index" do 
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
      end
        
      it "exposes logged in user as @user" do
        get :index
        assigns[:user].should == users(:ben)
      end

      describe "with mime type of xml" do
        it "renders user's timesheets as xml" do
          Timesheet.should_receive(:find).and_return(timesheets = mock("Array of Timesheets"))
          timesheets.should_receive(:to_xml).and_return("generated XML")
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
  
  describe "GET edit" do
    before(:each) do
      @date = Date.new(2009, 4, 6)
    end
    
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:zack))
      end
      
      it "exposes the current date as @date" do
        get :edit, :year => @date.year, :month => @date.month, :day => @date.day
        assigns[:date].should == @date
      end
  
      it "creates a new timesheet if the user doesn't have one for the given date" do
        Timesheet.should_receive(:new).with(hash_including(:start_date => @date, :user => users(:zack))).and_return(mock_timesheet)
        mock_timesheet.should_receive(:time_entries).and_return(mock_array = [])
        mock_array.should_receive(:build)
        get :edit, :year => @date.year, :month => @date.month, :day => @date.day
        assigns[:timesheet].should == mock_timesheet
      end
      
      it "retrieve's the user's timesheet for that date if there is one" do
        @date = Date.new(2006, 4, 13)
        Timesheet.should_receive(:scoped_by_user_id).with(users(:zack).id).and_return(mock_array = [])
        mock_array.should_receive(:find_by_start_date).with(@date).and_return(mock_timesheet)
        get :edit, :year => @date.year, :month => @date.month, :day => @date.day
        assigns[:timesheet].should == mock_timesheet 
      end
      
      describe "with mime type of xml" do
        it "renders the timesheet to be edited as xml" do
          Timesheet.should_receive(:new).with(hash_including(:start_date => @date, :user => users(:zack))).and_return(mock_timesheet)
          mock_timesheet.should_receive(:time_entries).and_return(mock_array = [])
          mock_array.should_receive(:build)
          mock_timesheet.should_receive(:to_xml).and_return("generated XML")
          get :edit, :year => @date.year, :month => @date.month, :day => @date.day, :format => 'xml'
          response.body.should == "generated XML"
        end
      end
    end
    
    describe "with no logged in user" do
      it "redirects to login page" do
        get :edit, :year => @date.year, :month => @date.month, :day => @date.day
        response.should redirect_to(new_user_session_url)
      end
    end
  end
  
  describe "POST create" do
    before(:each) do
      @date = Date.new(2009, 4, 20)
    end
    
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
      end

      it "re-displays the timesheet" do
        post :create, :timesheet => {:start_date => @date}
        response.should redirect_to("/timesheets/#{@date.year}/#{@date.month}/#{@date.day}")
      end
    end
    
    describe "with no logged in user" do
      it "redirects to login page" do
        post :create, :timesheet => {:these => 'params'}
        response.should redirect_to(new_user_session_url)
      end
    end
  end
  
  describe "PUT update" do
    before(:each) do
      @date = Date.new(2009, 4, 20)
    end
    
    describe "with logged in user" do
      before(:each) do
        UserSession.create(users(:ben))
      end

      it "re-displays the timesheet" do
        post :create, :timesheet => {:start_date => @date}
        response.should redirect_to("/timesheets/#{@date.year}/#{@date.month}/#{@date.day}")
      end
    end
    
    describe "with no logged in user" do
      it "redirects to login page" do
        post :create, :timesheet => {:these => 'params'}
        response.should redirect_to(new_user_session_url)
      end
    end
  end
end
