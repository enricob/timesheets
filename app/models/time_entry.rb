class TimeEntry < ActiveRecord::Base
  belongs_to :timesheet
  belongs_to :activity_type
  
  validates_presence_of :activity_type, :message => "must be selected"
  validates_numericality_of :hours, :only_integer => true, 
    :greater_than_or_equal_to => 1, :less_than_or_equal_to => 24
end
