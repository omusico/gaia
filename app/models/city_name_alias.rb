class CityNameAlias < ActiveRecord::Base
  include ActsAsIsEnabled
  acts_as_is_enabled
  
  belongs_to :city
  
  validates_uniqueness_of :name, :scope => [:city_id]
  
  
end
