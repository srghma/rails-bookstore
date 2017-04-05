FactoryGirl.define do
  sequence :country_name { |n| "country_name#{n}" }
  sequence :country_code { |n| "country_code#{n}" }

  factory :country, class: 'Shopper::Country' do
    name { generate(:country_name) }
    code { generate(:country_code) }
  end
end
