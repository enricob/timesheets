require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActivityType do
  dataset :activity_types
  
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    ActivityType.create!(@valid_attributes)
  end
  
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:project_id) }
  it { should belong_to(:project) }
  it { should have_many(:time_entries) }
end
