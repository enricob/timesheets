require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do

  it "should respond to new with login page" do
    get 'new'
    response.should render_template("views/user_session/new.html.erb")
  end

end
