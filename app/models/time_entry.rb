class TimeEntry < ActiveRecord::Base
  belongs_to :timesheet
  belongs_to :activity_type
  
  validates_presence_of :activity_type, :message => "must be selected"
  validates_numericality_of :hours,
    :greater_than => 0, :less_than_or_equal_to => 24
end
