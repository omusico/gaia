# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dist do
    city{ FactoryGirl.create :city }
    sequence(:name){ |n| "dist name #{n}" }
    is_enabled true
    factory :dist_disabled do
      is_enabled false
    end
    after(:create) do |dist, evaluator|
      FactoryGirl.create :dist_name_alias, :dist => dist
      FactoryGirl.create :dist_name_alias_disabled, :dist => dist
    end
  end
end