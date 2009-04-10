class TimeEntriesDataset < Dataset::Base
  uses :timesheets, :activity_types
  
  def load
    create_record :time_entry, :ben1, :timesheet_id => timesheets(:ben1).id, :entry_date => Date.new(2009,4,6),
      :activity_type_id => activity_types(:dev).id, :hours => 8, :description => "Coded some stuff"
      
    create_record :time_entry, :ben2, :timesheet_id => timesheets(:ben1).id, :entry_date => Date.new(2009,4,8),
      :activity_type_id => activity_types(:test).id, :hours => 4, :description => "Tested some stuff"
      
    create_record :time_entry, :zack1, :timesheet_id => timesheets(:zack1).id, :entry_date => Date.new(2009,4,14),
      :activity_type_id => activity_types(:planning).id, :hours => 6, :description => "Planned stuff"
      
    create_record :time_entry, :zack2, :timesheet_id => timesheets(:zack1).id, :entry_date => Date.new(2009,4,15),
      :activity_type_id => activity_types(:admin).id, :hours => 3, :description => "Paperwork!"
  end
end