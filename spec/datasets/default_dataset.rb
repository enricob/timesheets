class DefaultDataset < Dataset::Base
  uses :users, :projects, :activity_types, :timesheets, :time_entries
end