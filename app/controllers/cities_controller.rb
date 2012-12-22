class CitiesController < ApplicationController
  def index
    @cities = City.api_includes.enabled
    respond_as_api @cities.map{ |city| city.to_api_vars }
  end
  
  def show
    @city = City.api_includes.enabled.find(params[:id])
    respond_as_api @city.to_api_vars
  end

  def select
    init_html_vars
    @selected_city_id = params[:selected_city_id]
    @selected_dist_id = params[:selected_dist_id]
    @cities = City.scoped.enabled
    @dists = @selected_city_id ? City.find(@selected_city_id).dists : []
  end

  private 

  def init_html_vars
    @html_city = params[:html_city] || params[:html] || {}
    @html_dist = params[:html_dist] || params[:html] || {}
    @html_city[:name] ||= 'city_id'
    @html_city[:id] = 'city_id' unless @html_city[:name].present?
    @html_dist[:name] ||= 'dist_id'
    @html_dist[:id] = 'dist_id' unless @html_dist[:name].present?
  end

end