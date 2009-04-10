require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimesheetsController do
  describe "route recognition" do
    it "recognizes '/' as #index" do
      params_from(:get, '/').should == {:controller => "timesheets", :action => "index"}
    end
  end
end