# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    sequence(:name){ |n| "taipei#{n}" }
    area{ FactoryGirl.create :area }
    is_enabled true
    factory :city_disabled do
      is_enabled false
    end
    after(:create) do |city, evaluator|
      FactoryGirl.create :city_name_alias, :city => city
      FactoryGirl.create :city_name_alias_disabled, :city => city
    end
  end
end