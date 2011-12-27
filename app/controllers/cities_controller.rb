class CitiesController < ApplicationController
  def index
    @cities = City.api_includes.enabled
    respond_as_api @cities, :include => City::API_INCLUDES
  end
  
  def show
    @city = City.api_includes.enabled.find(params[:id])
    respond_as_api @city, :include => City::API_INCLUDES
  end
end