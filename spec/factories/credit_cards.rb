FactoryGirl.define do
  factory :credit_card, class: 'Shopper::CreditCard' do
    number          { CreditCardValidations::Factory.random :visa }
    cvv             '123'
    expiration_date { Time.current + 1.year }
    name            { FFaker::Name.name }
    order
  end
end
