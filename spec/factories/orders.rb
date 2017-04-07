FactoryGirl.define do
  factory :order, class: 'Shopper::Order' do
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

    trait :with_delivery do
      after(:create) do |order|
        order.delivery = create(:delivery)
        order.save
      end
    end

    trait :with_credit_card do
      after(:create) do |order|
        order.credit_card = create(:credit_card)
        order.save
      end
    end

    trait :use_billing do
      use_billing true

      after(:create) do |order|
        create(:billing_address, addressable: order)
      end
    end
  end
end
