FactoryGirl.define do
  factory :order do
    user

    trait :with_items do
      transient do
        number_of_items 3
      end

      after(:create) do |order, evaluator|
        create_list :order_item, evaluator.number_of_items, order: order
      end
    end
  end
end
