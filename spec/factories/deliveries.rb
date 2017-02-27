FactoryGirl.define do
  factory :delivery do
    title    { FFaker::DizzleIpsum.words }
    min_days 1
    max_days 5
    price    { FFaker.numerify('#.##') }
  end
end
