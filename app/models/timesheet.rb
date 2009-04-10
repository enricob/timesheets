class Timesheet < ActiveRecord::Base
  belongs_to :user
  has_many :time_entries, :dependent => :destroy
  accepts_nested_attributes_for :time_entries, :allow_destroy => true
  validate :starts_on_monday?
  
  def starts_on_monday?
    errors.add(:start_date, "doesn't start on Monday") if self.start_date.wday != 1
  end
end
