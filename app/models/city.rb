class City < ActiveRecord::Base
  include ActsAsIsEnabled
  acts_as_is_enabled
  
  include ActsAsManyNameAliases
  acts_as_many_name_aliases CityNameAlias
  
  validates_uniqueness_of :name
  validates_presence_of :name

  has_many :dists
      
end
