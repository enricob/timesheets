module TimesheetsHelper
  def date_path(date)
    "#{date.year}/#{date.month}/#{date.day}"
  end
  
  def start_of_week(date)
    offset = 1 - date.wday
    date + offset.days
  end
  
  def this_week
    start_of_week(Date.today)
  end
  
  def week_array(date)
    start = start_of_week(date)
    (start...start+7).to_a
  end
end
