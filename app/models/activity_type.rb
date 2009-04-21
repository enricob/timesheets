class ActivityType < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :project_id
  has_many :time_entries
end
