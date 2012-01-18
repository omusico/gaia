class CitiesController < ApplicationController
  def index
    @cities = City.api_includes.enabled
    respond_as_api @cities.map{ |city| city.to_api_vars }
  end
  
  def show
    @city = City.api_includes.enabled.find(params[:id])
    respond_as_api @city.to_api_vars
  end
  
end