require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :login => "value for login",
      :crypted_password => "value for crypted_password",
      :password_salt => "value for password_salt",
      :persistence_token => "value for persistence_token",
      :login_count => 1,
      :last_request_at => Time.now,
      :last_login_at => Time.now,
      :current_login_at => Time.now,
      :last_login_ip => "value for last_login_ip"
    }
  end

  # No specs for the User model, since it is exactly the Authlogic User model
end
