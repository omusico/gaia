class AreasController < ApplicationController

  def index
    @areas = Area.include_cities
    respond_as_api @areas.map{ |a| a.to_api_vars(:with => [:cities]) }
  end

  def show
    @area = Area.include_cities_and_dists.find(params[:id])
    respond_as_api @area.to_api_vars(:with => [:cities_and_dists])
  end

end
