FactoryGirl.define do
  factory :user do
    email    { FFaker::Internet.email }
    password { FFaker::Internet.password }

    factory :admin do
      is_admin true
    end
  end
end
