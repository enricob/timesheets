require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/show.html.erb" do
  before(:each) do
    assigns[:project] = @project = stub_model(Project,
      :name => "value for name",
      :description => "value for description"
    )
    @project.activity_types.create(:name => "Some Activity", :description => "Some Description")
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
  end
  
  it "renders activity types in <p>" do
    render
    response.should have_text(/Some\ Activity/)
    response.should have_text(/Some\ Description/)
  end
end

