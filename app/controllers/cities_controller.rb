class CitiesController < ApplicationController
  def index
    includes = [:name_aliases,{:dists=>[:name_aliases]}]
    @cities = City.includes(includes).enabled if !@cities
    respond_as_api @cities, :include => {:name_aliases=>{:only=>:name}, :dists=>{:only=>:name,:include=>{:name_aliases=>{:only=>:name}}}}
  end
end