# encoding: utf-8
require 'spec_helper'

describe "matching" do
  before do
    @city = FactoryGirl.create :city, :name => "新北市"
    @city2 = FactoryGirl.create :city, :name => "台南市"
    @city_name_alias = FactoryGirl.create :city_name_alias, :name => "北縣", :city => @city
    @city_name_alias2 = FactoryGirl.create :city_name_alias, :name => "南縣", :city => @city2
    @dist = FactoryGirl.create :dist, :city => @city, :name => "中和區"
    @dist2 = FactoryGirl.create :dist, :city => @city2, :name => "中區"
    @dist_name_alias = FactoryGirl.create :dist_name_alias, :name => "雙和", :dist => @dist
    @dist_name_alias2 = FactoryGirl.create :dist_name_alias, :name => "中西區", :dist => @dist2
  end
  
  describe "cities" do
    pending "case ignore"
  
    it "city2 should not match" do
      @city2.match?("新北").should be_false
    end

    it "city and city2 should match through name alias" do
      @city2.match?("台南縣").should be_true
      @city.match?("台北縣").should be_true
    end
  
    it "city and city2 should not match" do
      @city2.match?("桃園中壢苗栗").should be_false
      @city.match?("桃園中壢苗栗").should be_false
    end
    
    it "match by pure_name should be false" do
      @city.match?("新北").should be_false
      @city2.match?("台南").should be_false
    end
    
  end
  
  describe "dists" do
    it "case ignore" do
      @dist.name = "abc"
      @dist.match?("ABC").should be_true
      @dist2.name = "aBD"
      @dist2.match?("ABC").should be_false
    end
  
    it "dist match by name_alias" do
      @dist.match?("雙和國小").should be_true
      @dist2.match?("雙和國小").should be_false
    end

    it "match by pure_name should be false" do
      @dist.match?("中和").should be_false
      @dist2.match?("中西").should be_false
    end
    
  end
end
