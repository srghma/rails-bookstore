FactoryGirl.define do
  factory :delivery, class: 'Shopper::Delivery' do
    title    { FFaker::DizzleIpsum.words.join(' ') }
    min_days 1
    max_days 5
    price    { FFaker.numerify('#.##') }
  end
end
