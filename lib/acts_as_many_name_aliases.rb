module ActsAsManyNameAliases
  extend ActiveSupport::Concern
  
  module ClassMethods
    def acts_as_many_name_aliases klass
      has_many :name_aliases, :class_name => klass.to_s, :conditions => {:is_enabled => true}
      has_many :all_name_aliases, :class_name => klass.to_s
    end
  end
  
  module InstanceMethods
    
  end
  
end