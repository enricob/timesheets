require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Timesheet do
  dataset :users, :timesheets, :time_entries
  
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
    timesheet = Timesheet.create({:start_date => Date.new(2009,4,10)})
    timesheet.should have(1).error_on(:start_date)
  end
  
  it "should accept nested attributes values for time entries" do
    test_sheet = timesheets(:ben1)
    new_attributes = {:time_entries_attributes => [{:id => test_sheet.time_entries.first.id, :hours => "2"}]}
    test_sheet.update_attributes(new_attributes)
    test_sheet.time_entries.first.hours.should == 2
  end
  
  it "should allow destruction of time entries via nested values" do
    test_sheet = timesheets(:ben1)
    new_attributes = {:time_entries_attributes => [{:id => test_sheet.time_entries.first.id, "_delete" => "1"}]}
    test_sheet.update_attributes(new_attributes)
    assert test_sheet.time_entries.count.should == 1
  end
  
  it "should destroy its time entries when it is deleted" do
    timesheets(:ben1).destroy
    TimeEntry.all.length.should == 2
  end
  
  it "should not allow days to be overcharged (> 24 hours)" do
    test_sheet = timesheets(:zack1)
    test_sheet.time_entries.create(:entry_date => Date.new(2009,4,14),
      :activity_type_id => activity_types(:planning).id, :hours => 20, :description => "Long shift!")
    test_sheet.save.should == false
  end
  
  it "should return queries in descending order of start_date by default" do
    Timesheet.all.should == Timesheet.find(:all, :order => "start_date DESC")
  end
end
