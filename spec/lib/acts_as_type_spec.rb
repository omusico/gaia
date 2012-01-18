# encoding: utf-8
require 'spec_helper'

describe "city" do
  before do
    @city = Factory :city, :name => "花蓮縣"
  end
  
  it "#pure_name" do
    @city.pure_name.should == "花蓮"
  end

  it "#type_name" do
    @city.type_name.should == "縣"
  end
end

describe "dist" do
  before do
    @dist = Factory :dist, :name => "玉里鎮"
  end
  
  it "#pure_name" do
    @dist.pure_name.should == "玉里"
  end

  it "#type_name" do
    @dist.type_name.should == "鎮"
  end
end