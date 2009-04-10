require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  dataset :projects, :activity_types
  
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
    new_attributes = {:activity_types_attributes => [{:id => test_proj.activity_types.first.id, :name => "Stuff"}]}
    test_proj.update_attributes(new_attributes)
    test_proj.activity_types.first.name.should == "Stuff"
  end
  
  it "should allow destruction of activity types via nested values" do
    test_proj = projects(:project_x)
    new_attributes = {:activity_types_attributes => [{:id => activity_types(:test).id.to_s, "_delete" => "1"}]}
    test_proj.update_attributes(new_attributes)
    assert test_proj.activity_types.count.should == 2
  end
  
  it "should destroy its activity types when it is deleted" do
    projects(:project_x).destroy
    ActivityType.all.length.should == 2
  end
end
