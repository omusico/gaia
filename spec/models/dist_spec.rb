require 'spec_helper'

describe Dist do
  it "FactoryGirl create" do
    @dist = FactoryGirl.create :dist
    @dist.city.present?.should be_true
    @dist.area.present?.should be_true
  end

  it "should validate_uniqueness_of name" do
    FactoryGirl.create :dist
    should validate_uniqueness_of(:name).scoped_to([:city_id])
  end
  it { should validate_presence_of(:name) }
  it { should belong_to(:city) }
  
  pending "#to_api_vars"
end
