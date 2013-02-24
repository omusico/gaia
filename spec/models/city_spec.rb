require 'spec_helper'

describe City do
  it "should validate_uniqueness_of name" do
    FactoryGirl.create :city
    should validate_uniqueness_of(:name) 
  end
  it { should validate_presence_of(:name) }
  it { should have_many(:dists) }
  
  pending "#to_api_vars"
end
