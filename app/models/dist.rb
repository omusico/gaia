# encoding: utf-8
class Dist < ActiveRecord::Base
  TYPES = [ "區", "鄉", "鎮", "市" ]
  include ActsAsHasType
  
  include ActsAsMatching
  
  include ActsAsIsEnabled
  acts_as_is_enabled
  
  include ActsAsManyNameAliases
  acts_as_many_name_aliases DistNameAlias
  
  scope :api_includes, includes([{:city=>:name_aliases}, :name_aliases])
  API_INCLUDES = {:name_aliases => {:only => :name},:city => {:only => :name, :include => {:name_aliases=>{:only=>:name}}}}
  
  validates_uniqueness_of :name, :scope => [:city_id]
  validates_presence_of :name

  belongs_to :city

  def to_api_vars opts = {}
    withouts = (opts[:without] || []).map{ |s|s.to_sym }
    vars = { 
      :id => id, :name => :name, 
      :pure_name => pure_name, 
      :type_name => type_name
    }
    vars[:name_aliases] = name_aliases.map { |a| a.name } unless withouts.include?(:name_aliases)
    if withouts.include?(:city)
      vars[:city] = city.to_api_vars(:without=>[:dists]) 
    else
      vars[:city_id] = city_id
    end
    vars
  end
  
end
