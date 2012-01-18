module ActsAsHasType
  extend ActiveSupport::Concern

  module ClassMethods
  end
  
  module InstanceMethods
    def type_name
      name.gsub(pure_name, "")
    end

    def pure_name
      str = name
      eval("#{self.class.to_s}::TYPES").each do |type_name|
        str = str.gsub(type_name, "")
      end
      str
    end
  end
  
end