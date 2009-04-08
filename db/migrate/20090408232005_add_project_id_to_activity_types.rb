class AddProjectIdToActivityTypes < ActiveRecord::Migration
  def self.up
    add_column :activity_types, :project_id, :integer
  end

  def self.down
    remove_column :activity_types, :project_id
  end
end
