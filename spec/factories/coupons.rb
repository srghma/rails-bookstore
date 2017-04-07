FactoryGirl.define do
  sequence :coupon_code do |n|
    n.to_s.rjust(5, '0')
  end

  factory :coupon, class: 'Shopper::Coupon' do
    code { generate :coupon_code }
    discount { rand(100) }
  end
end
