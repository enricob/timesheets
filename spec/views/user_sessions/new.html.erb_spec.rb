require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

require 'authlogic/test_case'

describe "/user_sessions/new.html.erb" do
  include UserSessionsHelper
  
  before(:each) {
    activate_authlogic
    assigns[:user_session] = @user_session = UserSession.new
  }

  it "renders the login form" do
    render
    
    response.should have_tag("form[action=#{user_session_path}][method='post']") do
      with_tag('input#user_session_login[name=?]', "user_session[login]")
      with_tag('input#user_session_password[name=?][type=?]', "user_session[password]", "password")
      with_tag('input#user_session_remember_me[name=?][type=?]', "user_session[remember_me]", "checkbox")
    end
  end
end
