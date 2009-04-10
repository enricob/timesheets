require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimeEntry do
  dataset :users, :projects, :activity_types
  
  before(:each) do
    @valid_attributes = {
      :entry_date => Time.now,
      :activity_type => activity_types(:dev),
      :hours => 1,
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    TimeEntry.create!(@valid_attributes)
  end
  
  it { should belong_to(:timesheet) }
  it { should belong_to(:activity_type) }
end
