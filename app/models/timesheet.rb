class Timesheet < ActiveRecord::Base
  default_scope :order => "start_date DESC"
  
  belongs_to :user
  has_many :time_entries, :dependent => :destroy
  accepts_nested_attributes_for :time_entries, :allow_destroy => true
  validate :starts_on_monday, :no_overcharged_days
  
  def starts_on_monday
    date = self.start_date
    errors.add(:start_date, "isn't a Monday") unless date.wday == 1
  end
  
  def no_overcharged_days
    date = self.start_date
    for d in (date...date + 7.days) do
      entries_for_date = self.time_entries.select { |t| t.valid? && t.entry_date == d }
      hours_for_date = entries_for_date.inject(0) { |sum, t| sum + t.hours }
      errors.add_to_base("#{date} has more than 24 hours logged") unless hours_for_date <= 24
    end
  end
end
