# encoding: utf-8
class City < ActiveRecord::Base
  TYPES = ["縣", "市"]
  include ActsAsHasType
  
  include ActsAsMatching
  
  include ActsAsIsEnabled
  acts_as_is_enabled
  
  include ActsAsManyNameAliases
  acts_as_many_name_aliases CityNameAlias
  
  scope :include_names, includes(:name_aliases)
  scope :include_dists, includes(:dists => :name_aliases)
  scope :include_area, includes(:area)
  
  validates_uniqueness_of :name
  validates_presence_of :name

  has_many :dists, :conditions => { :is_enabled => true }
  belongs_to :area
      
  def to_api_vars(with: [])
    vars = { 
      :id => id,
      :name => name,
      :pure_name => pure_name,
      :type_name => type_name,
      :area_id => area_id
    }
    vars[:name_aliases] = alias_name_list if with.include?(:name_aliases)
    vars[:area] = area.to_api_vars if with.include?(:area)
    vars[:dists] = dists.map{ |d| d.to_api(:with => [:name_aliases]) } if with.include?(:dists)
    vars
  end

end
