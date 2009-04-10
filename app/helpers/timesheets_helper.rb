module TimesheetsHelper
  def date_path(date)
    "#{date.year}/#{date.month}/#{date.day}"
  end
  
  def this_week
    today = Date.today
    offset = 1 - today.wday
    today + offset.days
  end
end
