# encoding: utf-8
class Dist < ActiveRecord::Base
  TYPES = [ "區", "鄉", "鎮", "市" ]
  include ActsAsHasType
  
  include ActsAsMatching
  
  include ActsAsIsEnabled
  acts_as_is_enabled
  
  include ActsAsManyNameAliases
  acts_as_many_name_aliases DistNameAlias
  
  scope :include_names, includes(:name_aliases)
  scope :include_city, includes(:city => [:name_aliases, :area])
  scope :include_area, includes(:area)
  
  validates_uniqueness_of :name, :scope => [:city_id]
  validates_presence_of :name

  belongs_to :city
  belongs_to :area

  before_save{ self.area_id = city.area_id }

  def to_api_vars(with: [])
    vars = { :id => id, 
      :name => name, 
      :zipcode => zipcode,
      :pure_name => pure_name, 
      :type_name => type_name,
      :city_id => city_id,
      :area_id => area_id
    }
    vars[:name_aliases] = alias_name_list if with.include?(:name_aliases)
    vars[:city] = city.to_api_vars(:with => [:name_aliases, :area]) if with.include?(:city)
    vars[:area] = area.to_api_vars if with.include?(:area)
    vars
  end

end
