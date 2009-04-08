require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActivityTypesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "activity_types", :action => "index").should == "/activity_types"
    end
  
    it "maps #new" do
      route_for(:controller => "activity_types", :action => "new").should == "/activity_types/new"
    end
  
    it "maps #show" do
      route_for(:controller => "activity_types", :action => "show", :id => "1").should == "/activity_types/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "activity_types", :action => "edit", :id => "1").should == "/activity_types/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "activity_types", :action => "create").should == {:path => "/activity_types", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "activity_types", :action => "update", :id => "1").should == {:path =>"/activity_types/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "activity_types", :action => "destroy", :id => "1").should == {:path =>"/activity_types/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/activity_types").should == {:controller => "activity_types", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/activity_types/new").should == {:controller => "activity_types", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/activity_types").should == {:controller => "activity_types", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/activity_types/1").should == {:controller => "activity_types", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/activity_types/1/edit").should == {:controller => "activity_types", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/activity_types/1").should == {:controller => "activity_types", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/activity_types/1").should == {:controller => "activity_types", :action => "destroy", :id => "1"}
    end
  end
end
