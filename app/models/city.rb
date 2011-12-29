class City < ActiveRecord::Base
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
      
end
