require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/activity_types/index.html.erb" do
  include ActivityTypesHelper
  
  before(:each) do
    assigns[:activity_types] = [
      stub_model(ActivityType,
        :name => "value for name",
        :description => "value for description"
      ),
      stub_model(ActivityType,
        :name => "value for name",
        :description => "value for description"
      )
    ]
  end

  it "renders a list of activity_types" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
  end
end

