FactoryGirl.define do
  sequence :uid

  factory :user do
    email    { FFaker::Internet.email }
    password { FFaker::Internet.password }
    provider nil
    uid      nil

    trait :facebook_registered do
      provider 'facebook'
      uid
    end
  end
end
