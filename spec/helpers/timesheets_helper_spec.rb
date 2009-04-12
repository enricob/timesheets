require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TimesheetsHelper do
  include TimesheetsHelper
  
  before(:each) do
    @date = Date.today
  end
  
  describe "#date_path" do
    it "should return a relative path built from the given date" do
      date_path(@date).should == "#{@date.year}/#{@date.month}/#{@date.day}"
    end
  end
  
  describe "#week_array" do
    it "should build an array containing all days within the week of the given date" do
      test_array = week_array(@date)
      for d in (@date.beginning_of_week...@date.beginning_of_week + 7.days) do
        assert test_array.include? d
      end
    end
  end
end
