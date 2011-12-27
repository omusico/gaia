module ControllerBelongsToCity
  extend ActiveSupport::Concern
  
  module ClassMethods
    def controller_belongs_to_city
      before_filter :get_city
    end
  end
  
  module InstanceMethods
    
    protected
    
    def get_city
      if params[:city_id]
        @city = City.find(params[:city_id])
      end
    end
    
  end
  
end