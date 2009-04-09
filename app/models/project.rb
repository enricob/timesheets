class Project < ActiveRecord::Base
  has_many :activity_types, :dependent => :destroy
  validates_presence_of :name
  accepts_nested_attributes_for :activity_types, :allow_destroy => true
end
