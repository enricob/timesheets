class TimeEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :activity_type
end
