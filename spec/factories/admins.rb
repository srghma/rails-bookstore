FactoryGirl.define do
  factory :admin do
    email    { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end
