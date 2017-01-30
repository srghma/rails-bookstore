FactoryGirl.define do
  factory :category do
    title { FFaker::Book.genre }
  end
end
