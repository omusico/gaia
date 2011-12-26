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
  
  def includes_for_city
    {:name_aliases=>{:only=>:name}, :dists=>{:only=>:name,:include=>{:name_aliases=>{:only=>:name}}}}
  end
  
  def includes_for_dist
    {:name_aliases => {:only => :name},:city => {:only => :name, :include => {:name_aliases=>{:only=>:name}}}}
  end
end
