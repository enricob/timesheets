require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  fixtures :users
  
  before(:each) do
    @ben = users(:ben)
    @zack = users(:zack)
  end
  
  # Just check to make sure we declared "acts_as_authentic"
  it "should act as authentic" do
    @ben.respond_to?(:password=)
    @ben.respond_to?(:valid_password?)
  end
end
