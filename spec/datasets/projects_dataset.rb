class ProjectsDataset < Dataset::Base
  def load
    create_project :name => "ProjectX", :description => "Doing cool things with the power of science!"
    create_project :name => "ProjectE", :description => "Protecting our green Earth"
  end

  helpers do
    def create_project(attributes={})
      create_record :project, attributes[:name].underscore.to_sym,
        :name => attributes[:name],
        :description => attributes[:description]
    end
  end
end