class User < ActiveRecord::Base
  acts_as_authentic
  has_many :timesheets
  has_many :time_entries, :through => :timesheets
  
  def hours_on(project)
    project.time_entries.
      find(:all, :include => [:timesheet], :conditions => "timesheets.user_id = #{self.id}").
        inject(0){|sum, te|sum + te.hours}
  end
end
