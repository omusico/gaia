class CitiesController < ApplicationController
  
  def index
    @cities = City.include_names.include_area.enabled
    respond_as_api @cities.map{ |c| c.to_api_vars(:with => [:area, :name_aliases]) }
  end
  
  def show
    @city = City.include_names.include_dists.enabled.find(params[:id])
    respond_as_api @city.to_api_vars(:with => [:dists, :area, :name_aliases])
  end

  def select
    init_html_vars
    @selected_dist_id = params[:selected_dist_id]
    @selected_city_id = get_selected_city_id(@selected_dist_id)
    @cities = City.scoped.enabled
    @dists = @selected_city_id.present? ? City.find(@selected_city_id).dists : []
    @random = Time.now.usec.to_s[-6..-1]
  end

  def name
    @city = City.find params[:id]
  end

  private 

  def get_selected_city_id(dist_id)
    if(dist_id.present?)
      Dist.find(dist_id).city_id
    else
      params[:selected_city_id]
    end
  end

  def init_html_vars
    @html_city = params[:html_city] || params[:html] || {}
    @html_dist = params[:html_dist] || params[:html] || {}
    @html_city[:name] ||= 'city_id'
    @html_city[:id] = 'city_id' unless @html_city[:name].present?
    @html_dist[:name] ||= 'dist_id'
    @html_dist[:id] = 'dist_id' unless @html_dist[:name].present?
  end

end