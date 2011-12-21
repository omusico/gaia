class ApplicationController < ActionController::Base
  protect_from_forgery
  def respond_as_api vars, options = {}
    respond_to do |f|
      f.html
      f.js
      f.json {render :json => vars.to_json(:include => options[:include])}
      f.xml {render :xml => vars.to_xml}
    end
  end
end
