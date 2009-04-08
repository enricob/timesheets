class Project < ActiveRecord::Base
  has_many :activity_types
  validates_presence_of :name
  accepts_nested_attributes_for :activity_types
end
