require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/show.html.erb" do
  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :login => "value for login",
      :crypted_password => "value for crypted_password",
      :password_salt => "value for password_salt",
      :persistence_token => "value for persistence_token",
      :login_count => 1,
      :last_login_ip => "value for last_login_ip"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ login/)
    response.should have_text(/value\ for\ crypted_password/)
    response.should have_text(/value\ for\ password_salt/)
    response.should have_text(/value\ for\ persistence_token/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ last_login_ip/)
  end
end

