class Dist < ActiveRecord::Base
  include ActsAsIsEnabled
  acts_as_is_enabled
  
  # include ActsAsManyNameAliases
  # acts_as_many_name_aliases CityNameAlias
  
  validates_uniqueness_of :name, :scope => [:city_id]
  validates_presence_of :name

  belongs_to :city    
end
