FactoryGirl.define do
  factory :country do
    name { FFaker::Address.country }
    code { FFaker::Address.country_code }
  end
end
