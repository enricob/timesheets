require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do
  describe "route generation" do
    it "maps #new" do
      route_for(:controller => "user_sessions", :action => "new").should == "/session/new"
    end
    
    it "maps #create" do
      route_for(:controller => "user_sessions", :action => "create").should == {:path => "/session", :method => :post}
    end
    
    it "maps #destroy" do
      route_for(:controller => "user_sessions", :action => "destroy").should == {:path => "/session", :method => :delete}
    end
  end
  
  describe "route recognition" do
    it "recognizes '/' as #new" do
      params_from(:get, "/").should == {:controller => "user_sessions", :action => "new"}
    end
    
    it "generates params for #new" do
      params_from(:get, "/session/new").should == {:controller => "user_sessions", :action => "new"}
    end
    
    it "generates params for #create" do
      params_from(:post, "/session").should == {:controller => "user_sessions", :action => "create"}
    end
    
    it "generates params for #destroy" do
      params_from(:delete, "/session").should == {:controller => "user_sessions", :action => "destroy"}
    end
  end
end