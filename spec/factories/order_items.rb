FactoryGirl.define do
  factory :order_item, class: 'Shopper::OrderItem' do
    quantity 1
    order
    association :product, factory: :book
  end
end
