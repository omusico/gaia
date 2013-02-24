module ActsAsHasType
  extend ActiveSupport::Concern

  module ClassMethods
  end
  
  def type_name
    name.gsub(pure_name, "")
  end

  def pure_name
    str = name
    eval("#{self.class.to_s}::TYPES").each do |type_name|
      tmp_str = str.gsub(type_name, "")
      str = tmp_str if tmp_str.size > 1
    end
    str
  end
  
end