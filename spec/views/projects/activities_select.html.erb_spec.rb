require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/activities_select.html.erb" do
  before(:each) do
    assigns[:project] = @project = stub_model(Project,
      :id => 37, :name => "TestProject", :description => "Test")
    @project.activity_types.create(:name => "Activity1")
    @project.activity_types.create(:name => "Activity2")
    assigns[:form_id] = @form_id = "my_form_id"
    assigns[:form_name] = @form_name = "my_form_name"
  end
  
  it "should render a select tag with form_id and form_name" do
    render
    response.should have_tag("select[id=?][name=?]", @form_id, @form_name)
  end
  
  it "should render the activity types associated with the project as option tags" do
    render
    response.should have_tag("option[value=?]", @project.activity_types.first.id,
      :text => "Activity1")
    response.should have_tag("option[value=?]", @project.activity_types.second.id,
      :text => "Activity2")
  end
end