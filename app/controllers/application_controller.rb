class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  
  def respond_as_api vars, options = {}
    respond_to do |f|
      f.html
      f.js
      f.json {render :json => vars.to_json(:include => options[:include])}
      f.xml {render :xml => vars.to_xml(:include => options[:include])}
    end
  end
  
end
