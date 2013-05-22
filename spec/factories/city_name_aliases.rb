# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city_name_alias do
    sequence(:name){ |n| "name#{n}" }
    city{ FactoryGirl.create :city }
    is_enabled true
    factory :city_name_alias_disabled do
      is_enabled false
    end
  end
end