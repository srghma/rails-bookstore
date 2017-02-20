FactoryGirl.define do
  factory :order_item do
    quantity 1
    order
    book
    # association :product, factory: :book
  end
end
