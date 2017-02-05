FactoryGirl.define do
  factory :user do
    email    { FFaker::Internet.email }
    password { FFaker::Internet.password }

    factory :admin do
      is_admin true
    end

    trait :have_avatar do
      avatar do
        image_path = Rails.root.join('spec', 'fixtures', 'assets', 'avatar_example.png')
        Rack::Test::UploadedFile.new(image_path)
      end
    end
  end
end
