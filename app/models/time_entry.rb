class TimeEntry < ActiveRecord::Base
  belongs_to :timesheet
  belongs_to :activity_type
end
