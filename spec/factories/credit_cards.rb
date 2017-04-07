FactoryGirl.define do
  factory :credit_card, class: 'Shopper::CreditCard' do
    number          '4014876776827775'
    cvv             '123'
    expiration_date { Time.current + 1.year }
    name            { FFaker::Name.name }
    order
  end
end
