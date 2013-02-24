require 'spec_helper'

describe Dist do
  it "should validate_uniqueness_of name" do
    FactoryGirl.create :dist
    should validate_uniqueness_of(:name).scoped_to([:city_id])
  end
  it { should validate_presence_of(:name) }
  it { should belong_to(:city) }
  
  pending "#to_api_vars"
end
