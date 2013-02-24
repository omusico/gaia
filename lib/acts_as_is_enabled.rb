module ActsAsIsEnabled
  extend ActiveSupport::Concern
  
  module ClassMethods
    def acts_as_is_enabled
      scope :enabled, where(:is_enabled => true)
      scope :disabled, where(:is_enabled => [false,nil])
    end
  end
  
  def disabled?
    !is_enabled
  end
  
  def enabled?
    is_enabled
  end
  
  def enable
    update_attributes :is_enabled => true
  end
  
  def disable
    update_attributes :is_enabled => false
  end
  
end