class CreateTimeEntries < ActiveRecord::Migration
  def self.up
    create_table :time_entries do |t|
      t.references :timesheet
      t.datetime :entry_date
      t.references :user
      t.references :project
      t.integer :hours
      t.references :activity_type
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :time_entries
  end
end
