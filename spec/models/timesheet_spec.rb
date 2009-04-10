require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Timesheet do
  dataset :users
  
  before(:each) do
    @valid_attributes = {
      :start_date => Date.new(2009,4,6),
      :user => users(:ben)
    }
  end

  it "should create a new instance given valid attributes" do
    Timesheet.create!(@valid_attributes)
  end
  
  it { should belong_to(:user) }
  it { should have_many(:time_entries) }
  
  it "should verify that start_date is a Monday" do
    @valid_attributes.merge(:start_date => Date.new(2009,4,6))
    timesheet = Timesheet.create!(@valid_attributes)
    timesheet.should have(1).error_on(:start_date)
  end
end
