class DistsController < ApplicationController
  
  include ControllerBelongsToCity  
  controller_belongs_to_city

  def index
    @dists = @city.dists.api_includes.enabled
    respond_as_api @dists, :include => Dist::API_INCLUDES
  end
  
  def show
    @dist = @city.dists.api_includes.enabled.find(params[:id])
    respond_as_api @dist, :include => Dist::API_INCLUDES
  end
  
end
