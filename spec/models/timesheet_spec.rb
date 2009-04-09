require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Timesheet do
  dataset :users
  
  before(:each) do
    @valid_attributes = {
      :start_date => Time.now,
      :user => users(:ben)
    }
  end

  it "should create a new instance given valid attributes" do
    Timesheet.create!(@valid_attributes)
  end
  
  it { should belong_to(:user) }
  it { should have_many(:time_entries) }
end
