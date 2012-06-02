# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dist do
    city do
      FactoryGirl.create :city_enabled
    end
    name "tttp"
    factory :dist_enabled do
      name "tptp"
      is_enabled true
    end
    factory :dist_disabled do
      name "pttt"
      is_enabled false
    end
  end
end