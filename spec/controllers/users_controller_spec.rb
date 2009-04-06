require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'authlogic/test_case'

describe UsersController do
  fixtures :users
  
  before(:each) do
    @ben = users(:ben)
    @zack = users(:zack)
    activate_authlogic
  end
  
  it "should reject new requests for a logged in user" do
    UserSession.create(@ben)
    get 'new'
    response.should redirect_to("/account")
    assert flash[:notice] == "You must be logged out to access this page"
  end
  
  it "should reject create requests for a logged in user" do
    UserSession.create(@zack)
    post 'create'
    response.should redirect_to("/account")
    assert flash[:notice] == "You must be logged out to access this page"
  end

  it "should reject show requests if there is no session" do
    get 'show'
    response.should redirect_to("/session/new")
  end
  
  it "should reject edit if there is no session" do
    get 'edit'
    response.should redirect_to("/session/new")
  end
  
  it "should reject update if there is no session" do
    post 'update'
    response.should redirect_to("/session/new")
  end
  
  it "should respond to new with new.html.erb if there's no user logged in" do
    get 'new'
    response.should render_template('users/new.html.erb')
  end
  
  it "should respond to show with show.html.erb for logged in user" do
    UserSession.create(@ben)
    get 'show'
    assert assigns[:user] == @ben # make sure we're showing the right user!
    response.should render_template('users/show.html.erb')
  end
  
  it "should respond to edit with edit.html.erb for logged in user" do
    UserSession.create(@zack)
    get 'edit'
    assert assigns[:user] == @zack # make sure we're editing the right user!
    response.should render_template('users/edit.html.erb')
  end
  
  it "should respond to update with logged in user" do
    UserSession.create(@ben)
    post 'update'
    response.should redirect_to("/account")
  end
end
