# encoding: utf-8
require 'spec_helper'

describe "matching" do
  before do
    @city = Factory :city_enabled, :name => "新北市"
    @city2 = Factory :city_enabled, :name => "台南市"
    @city_name_alias = Factory :city_name_alias_enabled, :name => "北縣", :city_id => @city.id
    @city_name_alias2 = Factory :city_name_alias_enabled, :name => "南縣", :city_id => @city2.id
    @dist = Factory :dist_enabled, :city_id => @city.id, :name => "中和區"
    @dist2 = Factory :dist_enabled, :city_id => @city2.id, :name => "中區"
    @dist_name_alias = Factory :dist_name_alias_enabled, :name => "雙和", :dist_id => @dist.id
    @dist_name_alias2 = Factory :dist_name_alias_enabled, :name => "中西區", :dist_id => @dist2.id
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
    
    it "match by pure_name" do
      @city.match?("新北").should be_true
      @city2.match?("台南").should be_true
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

    it "match by pure_name" do
      @dist.match?("中和").should be_true
      @dist2.match?("中西").should be_true
    end
    
  end
end
