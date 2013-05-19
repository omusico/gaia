class Area < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_uniqueness_of :name
  validates_presence_of :name
  has_many :cities
  has_many :dists
end
