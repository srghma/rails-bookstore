FactoryGirl.define do
  sequence :category_title do |n|
    "interesting title#{n}"
  end

  factory :category do
    title { generate(:category_title) }
  end
end
