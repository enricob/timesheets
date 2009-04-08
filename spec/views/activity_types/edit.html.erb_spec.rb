require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/activity_types/edit.html.erb" do
  include ActivityTypesHelper
  
  before(:each) do
    assigns[:activity_type] = @activity_type = stub_model(ActivityType,
      :new_record? => false,
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "renders the edit activity_type form" do
    render
    
    response.should have_tag("form[action=#{activity_type_path(@activity_type)}][method=post]") do
      with_tag('input#activity_type_name[name=?]', "activity_type[name]")
      with_tag('textarea#activity_type_description[name=?]', "activity_type[description]")
    end
  end
end


