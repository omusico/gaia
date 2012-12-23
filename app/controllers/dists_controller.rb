class DistsController < ApplicationController
  
  include ControllerBelongsToCity  
  controller_belongs_to_city

  def index
    @dists = @city.dists.api_includes.enabled
    respond_as_api @dists.map{ |dist| dist.to_api_vars }
  end
  
  def show
    @dist = @city.dists.api_includes.enabled.find(params[:id])
    respond_as_api @dist.to_api_vars
  end

  def name
    @dist = Dist.find params[:id]
    @name = "#{params[:only] ? "" : @dist.city.name}#{@dist.name}"
  end

end
