class ActivityTypesDataset < Dataset::Base
  uses :projects
  
  def load
    create_record :activity_type, :design,
      :name => "design",
      :description => "Software Design and Modeling tasks",
      :project_id => projects(:project_x).id
    
    create_record :activity_type, :dev,
      :name => "development", 
      :description => "Software Development tasks",
      :project_id => projects(:project_x).id
      
    create_record :activity_type, :test,
      :name => "testing",
      :description => "Testing and QA tasks",
      :project_id => projects(:project_x).id
    
    create_record :activity_type, :planning,
      :name => "Planning",
      :description => "Planning movements and events",
      :project_id => projects(:project_e).id
    
    create_record :activity_type, :admin,
      :name => "Administration",
      :description => "Administration tasks",
      :project_id => projects(:project_e).id
  end
  
end