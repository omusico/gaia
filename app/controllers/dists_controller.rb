class DistsController < ApplicationController
  
  include ControllerBelongsToCity  
  controller_belongs_to_city

  def index
    @dists = @city.dists.include_names.enabled
    respond_as_api @dists.map{ |dist| dist.to_api_vars(:with => [:name_aliases]) }
  end
  
  def show
    @dist = @city.dists.include_names.include_city.enabled.find(params[:id])
    respond_as_api @dist.to_api_vars(:with => [:name_aliases, :city])
  end

  def name
    @dist = Dist.find params[:id]
    @name = "#{params[:only] ? "" : @dist.city.name}#{@dist.name}"
    @name = "#{@dist.zipcode} #{@name}" if params[:zipcode]
  end

  def zipcode
    @dist = Dist.find params[:id]
    @zipcode = "#{@dist.zipcode}"
  end

end
