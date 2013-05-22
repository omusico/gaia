require 'spec_helper'

describe DistsController do

  before do
    @dist = FactoryGirl.create :dist
    @city = @dist.city
    @area = @city.area
  end

  it "#zipcode" do
    get "/dists/#{@dist.id}/zipcode.js"
    response.should be_success
    expect {
      get "/dists/12341234/zipcode.js"
    }.to raise_error
  end

  it "#name" do
    get "/dists/#{@dist.id}/name.js"
    response.should be_success
    expect {
      get "/dists/12341234/name.js"
    }.to raise_error
  end

  describe "JSON APIs" do

    it "/cities/{city_id}/dists.json" do
      size = 20
      size.times{ FactoryGirl.create :dist, :city => @city }
      size.times{ FactoryGirl.create :dist }
      dists = request_api :get, "/cities/#{@city.id}/dists.json"
      it_should_be_dists(dists, :matched_dist => @dist, :city => @city, :area => @area)
      dists.each do |dist_hash|
        it_should_be_name_alias(dist_hash[:name_aliases])
      end
    end

    it "/cities/{city_id}/dists/{id}.json" do
      dist_hash = request_api :get, "/cities/#{@city.id}/dists/#{@dist.id}.json"
      it_should_be_dist(dist_hash, :city => @city, :area => @area)
      it_should_be_name_alias(dist_hash[:name_aliases], :dist => @dist)
      it_should_be_city(dist_hash[:city], :city => @city, :area => @area)
      it_should_be_area(dist_hash[:city][:area], :area => @area)
    end


  end
end