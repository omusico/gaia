class DistsController < ApplicationController
  
  include ControllerBelongsToCity  
  controller_belongs_to_city

  def index
    @dists = @city.dists.enabled
    respond_as_api @dists, :include => includes_for_dist
  end
  
  def show
    @dist = @city.dists.enabled.find(params[:id])
    respond_as_api @dist, :include => includes_for_dist
  end
  
end
