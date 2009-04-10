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
  it { should validate_presence_of(:activity_type).with_message("must be selected") }
  it { should validate_numericality_of(:hours) }
  it "should verify that hours is an integer" do
    @valid_attributes.merge!(:hours => 0.1)
    time_entry = TimeEntry.create(@valid_attributes)
    time_entry.should have(1).error_on(:hours)
  end
end
