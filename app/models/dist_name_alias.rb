class DistNameAlias < ActiveRecord::Base
  include ActsAsIsEnabled
  acts_as_is_enabled
  
  belongs_to :dist
  
  validates_uniqueness_of :name, :scope => [:dist_id]
  validates_presence_of :dist_id
end
