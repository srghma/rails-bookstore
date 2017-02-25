FactoryGirl.define do
  sequence :category_title { |n| "interesting title#{n}" }

  factory :category do
    title { generate(:category_title) }
  end
end
