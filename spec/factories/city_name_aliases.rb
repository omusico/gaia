# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city_name_alias do
    name "tp"
    city_id 1
    factory :city_name_alias_enabled do
      name "tpp"
      is_enabled true
    end
    factory :city_name_alias_disabled do
      name "ttpp"
      is_enabled false
    end
  end
end