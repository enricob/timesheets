require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/edit.html.erb" do
  before(:each) do
    assigns[:project] = @project = stub_model(Project,
      :new_record? => false,
      :name => "value for name",
      :description => "value for description"
    )
    @project.activity_types.create(:name => "Some Activity", :description => "Some Stuff")
  end

  it "renders the project form fields" do
    render
    response.should have_tag("form[action=#{project_path(@project)}][method=post]") do
      with_tag('input#project_name[name=?]', "project[name]")
      with_tag('textarea#project_description[name=?]', "project[description]")
    end
  end
  
  it "renders the activity type fields" do
    render
    response.should have_tag("div#activity_types") do
      with_tag('input#project_activity_types_attributes_0_id[name=?][type=?]', 
        "project[activity_types_attributes][0][id]", "hidden")
      with_tag('input#project_activity_types_attributes_0_name[name=?]',
        "project[activity_types_attributes][0][name]")
      with_tag('input#project_activity_types_attributes_0_description[name=?]',
        "project[activity_types_attributes][0][description]")
    end
  end
  
  it "renders a link back to timesheets" do
    render
    response.should have_tag("a[href=#{timesheets_path}]")
  end
end


