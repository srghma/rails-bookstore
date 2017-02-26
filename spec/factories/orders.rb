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

    trait :with_addresses do
      after(:create) do |order|
        create(:billing_address, addressable: order)
        create(:shipping_address, addressable: order)
      end
    end
  end
end
