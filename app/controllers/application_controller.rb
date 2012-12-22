class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  
  def respond_as_api vars, options = {}
    response.headers["Access-Control-Allow-Origin"] = "*"
    respond_to do |f|
      f.html
      f.js
      f.json { render :json => vars.to_json }
      f.xml { render :xml => vars.to_xml }
    end
  end
  
end
