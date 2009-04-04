require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/index.html.erb" do
  include UsersHelper
  
  before(:each) do
    assigns[:users] = [
      stub_model(User,
        :login => "value for login",
        :crypted_password => "value for crypted_password",
        :password_salt => "value for password_salt",
        :persistence_token => "value for persistence_token",
        :login_count => 1,
        :last_login_ip => "value for last_login_ip"
      ),
      stub_model(User,
        :login => "value for login",
        :crypted_password => "value for crypted_password",
        :password_salt => "value for password_salt",
        :persistence_token => "value for persistence_token",
        :login_count => 1,
        :last_login_ip => "value for last_login_ip"
      )
    ]
  end

  it "renders a list of users" do
    render
    response.should have_tag("tr>td", "value for login".to_s, 2)
    response.should have_tag("tr>td", "value for crypted_password".to_s, 2)
    response.should have_tag("tr>td", "value for password_salt".to_s, 2)
    response.should have_tag("tr>td", "value for persistence_token".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for last_login_ip".to_s, 2)
  end
end

