require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/timesheets/edit.html.erb" do
  include TimesheetsHelper
  
  dataset :time_entries
  # I don't like having view specs interact with the database but trying to stub out
  # all of the involved models is an exercise in pain and anguish.
  
  before(:each) do
    assigns[:date] = @date = Date.new(2009, 4, 13)
    assigns[:user] = @user = stub_model(User, {:login => "test_user"})
    assigns[:timesheet] = @timesheet = stub_model(Timesheet,
      :start_date => @date,
      :user => @user,
      :time_entries => [time_entries(:zack2)])
  end
  
  it "shows the current date" do
    render
    response.should include_text("Week Starting April 13, 2009")
  end
  
  it "renders options for time entry date" do
    render
    response.should have_tag("select[id=?][name=?]", 
      "timesheet_time_entries_attributes_0_entry_date",
      "timesheet[time_entries_attributes][0][entry_date]")
    for d in (@date...@date+7) do
      response.should have_tag("option[value=?]", d.to_s)
    end
  end
  
  it "renders options for activity type" do
    render
    response.should have_tag("select[id=?][name=?]",
      "timesheet_time_entries_attributes_0_activity_type_id",
      "timesheet[time_entries_attributes][0][activity_type_id]")
  end
  
  it "renders fields for hours and description" do
    render
    response.should have_tag("input[id=?][name=?][type=?]",
      "timesheet_time_entries_attributes_0_hours",
      "timesheet[time_entries_attributes][0][hours]",
      "text")
    response.should have_tag("input[id=?][name=?][type=?]",
      "timesheet_time_entries_attributes_0_description",
      "timesheet[time_entries_attributes][0][description]",
      "text")
  end
  
  it "renders a link to add a new time entry" do
    render
    response.should have_tag("a[href=?][class=?][rel=?]",
      "#time_entry", "add_nested_item", "time_entries")
  end
  
  it "renders a link to enter time for the previous week" do
    render
    response.should have_tag("a[href=?]", "/timesheets/2009/4/6")
  end
  
  it "renders a link to enter time for the next week" do
    render
    response.should have_tag("a[href=?]", "/timesheets/2009/4/20")
  end
  
  it "renders a link back to timesheets index" do
    render
    response.should have_tag("a[href=#{timesheets_path}]")
  end
end