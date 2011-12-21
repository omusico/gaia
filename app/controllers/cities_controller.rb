class CitiesController < ApplicationController
  def index
    @cities = City.includes(:name_aliases).enabled if !@cities
    respond_as_api @cities, :include => :name_aliases
  end
end