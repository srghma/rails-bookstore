FactoryGirl.define do
  sequence :uid

  factory :user do
    email    { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end
