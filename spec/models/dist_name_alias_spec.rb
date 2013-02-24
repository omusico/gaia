require 'spec_helper'

describe DistNameAlias do
  it "should validate uniqueness of name with scope dist " do
    FactoryGirl.create :dist_name_alias
    should validate_uniqueness_of(:name).scoped_to(:dist_id)
  end
  
  it { should belong_to(:dist) }
  it { should validate_presence_of(:dist_id) }
  
end
