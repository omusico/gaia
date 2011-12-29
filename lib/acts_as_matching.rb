module ActsAsMatching
  extend ActiveSupport::Concern

  module ClassMethods
  end
  
  module InstanceMethods
    def match?(text)
      res = false
      text = text.downcase
      match_methods.each do |method|
        res ||= send("match_with_#{method}", text) if respond_to?(method) && !res
      end
      res && true
    end
    
    private
    
    def match_methods
      [:name, :name_aliases]
    end
    
    def match_with_name text
      text.index(self.name.downcase)
    end
    
    def match_with_name_aliases text
      name_aliases.each do |name_alias|
        return true if text.index(name_alias.name.downcase)
      end
      false
    end
    
  end
end