require 'spec_helper'

describe AreasController do
  before do
    @area = FactoryGirl.create :area
  end

  describe "JSON APIs" do

    it "/areas.json" do
      size = 20
      size.times{ FactoryGirl.create :city, :area => @area }
      size.times{ FactoryGirl.create :city }
      areas = request_api :get, "/areas.json"
      it_should_be_areas(areas, :matched_area => @area)
      areas.size.should == size + 1
      areas.select{ |a| a[:id] == @area.id }.first[:cities].size.should == size
      areas.first[:cities].last.key?(:dists).should be_false
      areas.first[:cities].last.key?(:name_aliases).should be_true
    end

    it "/areas/{id}.json" do
      city_size = 10
      dist_size = 5
      city_size.times do
        city = FactoryGirl.create :city, :area => @area
        dist_size.times{ FactoryGirl.create :dist, :city => city }
      end
      area_hash = request_api :get, "/areas/#{@area.id}.json"
      it_should_be_area(area_hash, {})
      area_hash[:cities].size.should == city_size
      area_hash[:cities].last[:dists].size.should == dist_size
      area_hash[:cities].last.key?(:area).should be_false
      area_hash[:cities].last.key?(:name_aliases).should be_true
      area_hash[:cities].last[:dists].last.key?(:city).should be_false
      area_hash[:cities].last[:dists].last.key?(:name_aliases).should be_true
    end

  end

end
