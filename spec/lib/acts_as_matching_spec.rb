require 'spec_helper'

describe "matching" do
  before do
    @city = Factory :city_enabled, :name => "taipei"
    @city2 = Factory :city_enabled, :name => "tainan"
    @city_name_alias = Factory :city_name_alias_enabled, :name => "tp", :city_id => @city.id
    @city_name_alias2 = Factory :city_name_alias_enabled, :name => "tt", :city_id => @city2.id
    @dist = Factory :dist_enabled, :city_id => @city.id, :name => "abc"
    @dist2 = Factory :dist_enabled, :city_id => @city2.id, :name => "aaa"
    @dist_name_alias = Factory :dist_name_alias_enabled, :name => "aabbcc", :dist_id => @dist.id
    @dist_name_alias2 = Factory :dist_name_alias_enabled, :name => "bbb", :dist_id => @dist2.id
  end
  
  it "city should match with case ignore" do
    @city.match?("Taipei").should be_true
  end

  it "city2 should not match" do
    @city2.match?("Taipei").should be_false
  end

  it "city and city2 should match through name alias" do
    @city2.match?("ttpp").should be_true
    @city.match?("ttpp").should be_true
  end
  
  it "city and city2 should not match" do
    @city2.match?("totopop").should be_false
    @city.match?("totopop").should be_false
  end
  
  it "case ignore" do
    @dist.match?("ABC").should be_true
    @dist2.match?("ABC").should be_false
  end
  
  it "dist match by name_alias" do
    @dist.match?("BBBB").should be_false
    @dist2.match?("BBBB").should be_true
  end
end
