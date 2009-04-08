require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/new.html.erb" do
  include UsersHelper
  
  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :new_record? => true,
      :login => "testuser",
      :password_salt => (salt = Authlogic::Random.hex_token),
      :crypted_password => Authlogic::CryptoProviders::Sha512.encrypt("testuser" + salt),
      :persistence_token => Authlogic::Random.hex_token
    )
  end

  it "renders the new user form" do
    render
    
    response.should have_tag("form[action='/account'][method='post']") do
      with_tag('input#user_login[name=?]', "user[login]")
      with_tag('input#user_password[name=?][type=?]', "user[password]", "password")
      with_tag('input#user_password_confirmation[name=?][type=?]', "user[password_confirmation]", "password")
    end
  end
  
  it "renders the form partial" do
    template.should_receive(:render).with(hash_including(:partial => "form"))
    render
  end
end


