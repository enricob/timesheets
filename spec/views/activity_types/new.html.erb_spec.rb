require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/activity_types/new.html.erb" do
  include ActivityTypesHelper
  
  before(:each) do
    assigns[:activity_type] = stub_model(ActivityType,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "renders new activity_type form" do
    render
    
    response.should have_tag("form[action=?][method=post]", activity_types_path) do
      with_tag("input#activity_type_name[name=?]", "activity_type[name]")
      with_tag("textarea#activity_type_description[name=?]", "activity_type[description]")
    end
  end
end


