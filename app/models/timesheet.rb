class Timesheet < ActiveRecord::Base
  belongs_to :user
  has_many :time_entries, :dependent => :destroy
  accepts_nested_attributes_for :time_entries, :allow_destroy => true
end
