require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/new.html.erb" do
  include ProjectsHelper
  
  before(:each) do
    assigns[:project] = @project = stub_model(Project,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description"
    )
    @project.activity_types.build # this would happen in controller
  end

  it "renders new project form" do
    render
    
    response.should have_tag("form[action=?][method=post]", projects_path) do
      with_tag("input#project_name[name=?]", "project[name]")
      with_tag("textarea#project_description[name=?]", "project[description]")
    end
  end
  
  it "renders the activity type fields for a new record" do
    render
    
    response.should have_tag("div#activity_types") do
      with_tag('input#project_activity_types_attributes_0_name[name=?]',
        "project[activity_types_attributes][0][name]")
      with_tag('input#project_activity_types_attributes_0_description[name=?]',
        "project[activity_types_attributes][0][description]")
    end
  end
end


