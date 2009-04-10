require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timesheets/index.html.erb" do
  include TimesheetsHelper
  
  before(:each) do
    assigns[:user] = @user = stub_model(User)
    @user.timesheets.create(:start_date => Date.new(2009, 4, 6),
      :time_entries_attributes => [{:hours => 8}])
  end
  
  it "should render the user's timesheets" do
    render
    response.should have_tag("tr>td", "April 6, 2009")
    response.should have_tag("tr>td", "8")
  end
end