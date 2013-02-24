require 'spec_helper'

describe CityNameAlias do
  it "should validate uniqueness of name with scope city " do
    FactoryGirl.create :city_name_alias
    should validate_uniqueness_of(:name).scoped_to(:city_id)
  end
  
  it { should belong_to(:city) }
  it { should validate_presence_of(:city_id) }
  
end
