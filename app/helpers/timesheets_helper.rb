module TimesheetsHelper
  def date_path(date)
    "#{date.year}/#{date.month}/#{date.day}"
  end
  
  def this_week
    Date.today.beginning_of_week
  end
  
  def week_array(date)
    start = start_of_week(date)
    (start...start+7).to_a
  end
end
