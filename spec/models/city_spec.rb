require 'spec_helper'

describe City do
  it "should validate_uniqueness_of name" do
    Factory :city
    should validate_uniqueness_of(:name) 
  end
  
end
