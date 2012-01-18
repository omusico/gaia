# encoding: utf-8
class City < ActiveRecord::Base
  TYPES = ["縣", "市"]
  include ActsAsHasType
  
  include ActsAsMatching
  
  include ActsAsIsEnabled
  acts_as_is_enabled
  
  include ActsAsManyNameAliases
  acts_as_many_name_aliases CityNameAlias
  
  scope :api_includes, includes([:name_aliases,{:dists=>:name_aliases}])
  API_INCLUDES = {:name_aliases=>{:only=>:name}, :dists=>{:only=>[:id,:name],:include=>{:name_aliases=>{:only=>:name}}}}
  
  validates_uniqueness_of :name
  validates_presence_of :name

  has_many :dists, :conditions => {:is_enabled=>true}
      
  def to_api_vars opts = {}
    withouts = (opts[:without] || []).map{ |s|s.to_sym }
    vars = {
      :id => id,
      :name => name,
      :pure_name => pure_name,
      :type_name => type_name
    }
    vars[:name_aliases] = name_aliases.map{ |a| a.name } unless withouts.include?(:name_aliases)
    vars[:dists] = dists.map { |dist| dist.to_api_vars(:without => [:city]) } unless withouts.include?(:dists)
    vars
  end
end
