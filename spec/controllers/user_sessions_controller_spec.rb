require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do

  it "should respond to new with login page" do
    get 'new'
    response.should render_template("user_sessions/new.html.erb")
  end

end
