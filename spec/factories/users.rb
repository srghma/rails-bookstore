FactoryGirl.define do
  factory :user do
    email      { FFaker::Internet.email }
    password   { FFaker::Internet.password }
    first_name { FFaker::NameCN.first_name }
    last_name  { FFaker::NameCN.last_name }

    factory :admin do
      is_admin true
    end

    trait :with_addresses do
      after(:create) do |user|
        create(:billing_address, addressable: user)
        create(:shipping_address, addressable: user)
      end
    end
  end
end
