require 'spec_helper'

describe City do
  it "should validate_uniqueness_of name" do
    Factory :city
    should validate_uniqueness_of(:name) 
  end
  it { should validate_presence_of(:name) }
  it { should have_many(:dists) }
  it { should have_many(:all_dists) }
end
