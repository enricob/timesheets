require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/index.html.erb" do
  before(:each) do
    assigns[:projects] = [
      stub_model(Project,
        :name => "value for name",
        :description => "value for description"
      ),
      stub_model(Project,
        :name => "value for name",
        :description => "value for description"
      )
    ]
  end

  it "renders a list of projects" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
  end
  
  it "renders a link back to timesheets" do
    render
    response.should have_tag("a[href=#{timesheets_path}]")
  end
end

