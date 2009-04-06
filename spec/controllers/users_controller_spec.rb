require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do

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

end
