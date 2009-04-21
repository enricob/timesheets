require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  dataset :users, :time_entries
  
  before(:each) do
    @ben = users(:ben)
    @zack = users(:zack)
  end
  
  it "should act as authentic" do
    @ben.respond_to?(:password=)
    @ben.respond_to?(:valid_password?)
  end
  
  it { should have_many(:timesheets) }
  it { should have_many(:time_entries).through(:timesheets) }
  
  describe "#hours_on" do
    it "reports the number of hours the user has logged against a given project" do
      test_sheet = timesheets(:ben1)
      test_project = projects(:project_x)
      test_hours = 4.5
      lambda { test_sheet.time_entries.create(:entry_date => test_sheet.start_date, 
        :activity_type_id => test_project.activity_types.first.id,
        :hours => test_hours)}.should change { @ben.hours_on(test_project) }.by(test_hours)
    end
  end
end
