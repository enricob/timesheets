require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timesheets/index.html.erb" do
  include TimesheetsHelper
  
  before(:each) do
    assigns[:user] = @user = stub_model(User)
    @user.timesheets.create(:start_date => Date.new(2009, 4, 6),
      :time_entries_attributes => [{:hours => 2}, {:hours => 6}])
  end
  
  it "should render the user's timesheets" do
    render
    response.should have_tag("tr>td", "April  6, 2009")
    response.should have_tag("tr>td", "8")
  end
  
  it "should contain a link to manage projects" do
    render
    response.should have_tag("a[href=?]", "#{projects_path}")
  end
  
  it "should contain a link to enter time against the current week" do
    render
    response.should have_tag("a[href=?]", "/timesheets/#{date_path(this_week)}")
  end
end