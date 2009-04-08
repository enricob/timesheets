class ProjectsDataset < Dataset::Base
  def load
    create_project :name => "Project X", :description => "Doing cool things with the power of science!"
    create_project :name => "Project E", :description => "Protecting our green Earth"
  end

  helpers do
    def create_project(attributes={})
      create_record :project, attributes[:name].downcase.underscore,
        :name => attributes[:name],
        :description => attributes[:description]
    end
  end
end