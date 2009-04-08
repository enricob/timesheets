require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  dataset :projects
  
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end
  
  it { should validate_presence_of(:name) }
  it { should have_many(:activity_types) }
  
  it "should accept nested attributes values for activity types" do
    test_proj = projects(:project_x)
    new_attributes = {:activity_types_attributes => {"3" => {:name => "QA", :description => "QA Tasks"}}}
    assert test_proj.update_attributes!(new_attributes)
    # The above should throw an exception if Projects do not accept nested attribute values
  end
end
