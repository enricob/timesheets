class Project < ActiveRecord::Base
  has_many :activity_types
  validates_presence_of :name
end
