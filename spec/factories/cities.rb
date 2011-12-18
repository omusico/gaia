# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    name "taipei"
    factory :city_enabled do
      name "tainan"
      is_enabled true
    end
    factory :city_disabled do
      name "tn"
      is_enabled false
    end
  end
end