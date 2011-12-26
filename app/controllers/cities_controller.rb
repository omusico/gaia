class CitiesController < ApplicationController
  def index
    includes = [:name_aliases,{:dists=>[:name_aliases]}]
    @cities = City.includes(includes).enabled if !@cities
    respond_as_api @cities, :include => includes_for_city
  end
end