FactoryGirl.define do
  factory :order_item do
    quantity 1
    order
    association :productable, factory: :book
  end
end
