require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  describe "route generation" do
    it "maps #new" do
      route_for(:controller => "users", :action => "new").should == "/users/new"
    end
  
    it "maps #show" do
      route_for(:controller => "users", :action => "show", :id => "1").should == "/users/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "users", :action => "edit", :id => "1").should == "/users/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "users", :action => "create").should == {:path => "/users", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "users", :action => "update", :id => "1").should == {:path =>"/users/1", :method => :put}
    end
  end

  describe "route recognition" do
    it "generates params for #new" do
      params_from(:get, "/users/new").should == {:controller => "users", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/users").should == {:controller => "users", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/users/1").should == {:controller => "users", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/users/1/edit").should == {:controller => "users", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/users/1").should == {:controller => "users", :action => "update", :id => "1"}
    end
    
    it "generates params for #new through account" do
      params_from(:get, "/account/new").should == {:controller => "users", :action => "new"}
    end
    
    it "generates params for #edit through account" do
      params_from(:get, "/account/edit").should == {:controller => "users", :action => "edit"}
    end
    
    it "generates params for #show through account" do
      params_from(:get, "/account").should == {:controller => "users", :action => "show"}
    end
    
    it "generates params for #update through account" do
      params_from(:put, "/account").should == {:controller => "users", :action => "update"}
    end
    
    it "generates params for #create through account" do
      params_from(:post, "/account").should == {:controller => "users", :action => "create"}
    end
  end
end
