require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/activity_types/show.html.erb" do
  include ActivityTypesHelper
  before(:each) do
    assigns[:activity_type] = @activity_type = stub_model(ActivityType,
      :name => "value for name",
      :description => "value for description"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
  end
end

