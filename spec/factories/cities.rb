# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    sequence(:name){ |n| "taipei#{n}" }
    area{ FactoryGirl.create :area }
    factory :city_enabled do
      sequence(:name){ |n| "tainan#{n}" }
      is_enabled true
    end
    factory :city_disabled do
      sequence(:name){ |n| "tn#{n}" }
      is_enabled false
    end
  end
end