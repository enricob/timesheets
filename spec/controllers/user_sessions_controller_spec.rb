require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "authlogic/test_case"

describe UserSessionsController do
  before(:each) do
    activate_authlogic
  end
  
  it "should respond to new with login page" do
    get 'new'
    response.should render_template("user_sessions/new.html.erb")
  end
  
  it "should not have a current user if nobody logged in" do
    assert_nil @current_user
  end
end
