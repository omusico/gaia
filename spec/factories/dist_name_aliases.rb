# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dist_name_alias do
    sequence(:name){ |n| "dist name alias #{n}" } 
    dist{ FactoryGirl.create :dist }
    is_enabled true
    factory :dist_name_alias_disabled do
      is_enabled false
    end
  end
end