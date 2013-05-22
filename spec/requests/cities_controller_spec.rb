require 'spec_helper'

describe CitiesController do
  before do
    @city = FactoryGirl.create :city
  end

  describe "#select" do

    it "should success" do
      get "/select.js", :selected_city_id => @city.id, :selected_dist_id => ""
      response.should be_success
    end

    it "blank selected values" do
      City.destroy_all
      get "/select.js", :selected_city_id => "", :selected_dist_id => ""
      response.should be_success
    end

  end

  it "#name" do
    get "/cities/#{@city.id}/name.js"
    response.should be_success
    expect{
      get "/cities/123/name.js"
    }.to raise_error
  end

  describe "JSON APIs" do

    it "/cities.json" do
      5.times{ FactoryGirl.create :city }
      cities = request_api :get, "/cities.json"
      it_should_be_cities(cities, :matched_city => @city)
      cities.each do |city_hash|
        it_should_be_name_alias(city_hash[:name_aliases])
        city_hash.key?(:dists).should be_false
      end
    end

    it "/cities/{id}.json" do
      city_hash = request_api :get, "/cities/#{@city.id}.json"
      it_should_be_city(city_hash, :city => @city, :area => @city.area)
      it_should_be_name_alias(city_hash[:name_aliases], :city => @city)
      it_should_be_dists(city_hash[:dists], :city => @city, :area => @city.area)
    end

  end
end