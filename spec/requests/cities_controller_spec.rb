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
      random_size = 5
      random_size.times do
        city = FactoryGirl.create :city
        random_size.times{ FactoryGirl.create :dist, :city => city }
      end
      cities = request_api :get, "/cities.json"
      cities.size.should == random_size + 1
      it_should_be_cities(cities, :matched_city => @city)
      cities.each do |city_hash|
        it_should_be_name_alias(city_hash[:name_aliases])
        city_hash.key?(:dists).should be_false
      end
      cities.last.key?(:dists).should be_false
      cities.last.key?(:name_aliases).should be_true
    end

    it "/cities/{id}.json" do
      random_size = 5
      random_size.times{ FactoryGirl.create :dist, :city => @city }
      city_hash = request_api :get, "/cities/#{@city.id}.json"
      it_should_be_city(city_hash, :city => @city, :area => @city.area)
      it_should_be_name_alias(city_hash[:name_aliases], :city => @city)
      it_should_be_dists(city_hash[:dists], :city => @city, :area => @city.area)
      city_hash[:dists].size.should == random_size
      city_hash.key?(:area).should be_true
      city_hash[:area].key?(:cities).should be_false
      city_hash[:dists].last.key?(:city).should be_false
      city_hash[:dists].last.key?(:area).should be_false
      city_hash[:dists].last.key?(:name_aliases).should be_true
    end

  end
end