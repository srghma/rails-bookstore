FactoryGirl.define do
  factory :order_item do
    quantity 1
    order
    association :product, factory: :book
  end
end
