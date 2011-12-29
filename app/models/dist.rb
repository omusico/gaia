class Dist < ActiveRecord::Base
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
end
