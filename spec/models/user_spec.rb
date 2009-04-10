require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  fixtures :users
  
  before(:each) do
    @ben = users(:ben)
    @zack = users(:zack)
  end
  
  it "should act as authentic" do
    @ben.respond_to?(:password=)
    @ben.respond_to?(:valid_password?)
  end
  
  it { should have_many(:timesheets) }
end
