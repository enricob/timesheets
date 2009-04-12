require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimesheetsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "timesheets", :action => "index").should == "/timesheets"
    end
    
    it "maps #edit" do
      route_for(:controller => "timesheets", :action => "edit", :id => "1").should == "/timesheets/1/edit"
    end
    
    it "maps #create" do
      route_for(:controller => "timesheets", :action => "create").should == {:path => "/timesheets", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "timesheets", :action => "update", :id => "1").should == {:path =>"/timesheets/1", :method => :put}
    end
  end
  
  describe "route recognition" do
    it "recognizes '/' as #index" do
      params_from(:get, '/').should == {:controller => "timesheets", :action => "index"}
    end
    
    it "generates params for #index" do
      params_from(:get, '/timesheets').should == {:controller => "timesheets", :action => "index"}
    end
    
    it "generates params for #edit" do
      params_from(:get, '/timesheets/1/edit').should == {:controller => "timesheets", :action => "edit", :id => "1"}
    end
    
    it "generates params for #edit given date" do
      params_from(:get, '/timesheets/2009/4/13').should == {:controller => "timesheets", :action => "edit", :year => "2009", :month => "4", :day => "13"}
    end

    it "generates params for #create" do
      params_from(:post, "/timesheets").should == {:controller => "timesheets", :action => "create"}
    end
    
    it "generates params for #update" do
      params_from(:put, '/timesheets/1').should == {:controller => "timesheets", :action => "update", :id => "1"}
    end
  end
end