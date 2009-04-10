require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimeEntry do
  dataset :users, :projects, :activity_types
  
  before(:each) do
    @valid_attributes = {
      :entry_date => Time.now,
      :user => users(:ben),
      :project => projects(:project_x),
      :hours => 1,
      :activity_type => activity_types(:dev),
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    TimeEntry.create!(@valid_attributes)
  end
  
  it { should belong_to(:timesheet) }
end
