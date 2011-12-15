class City < ActiveRecord::Base
  include ActsAsIsEnabled
  acts_as_is_enabled
  
  validates_uniqueness_of :name
  
  
end
