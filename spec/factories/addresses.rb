FactoryGirl.define do
  factory :address, class: 'Shopper::Address' do
    country
    first_name { FFaker::Name.first_name }
    last_name  { FFaker::Name.last_name }
    city       { FFaker::AddressUS.city }
    street     { FFaker::AddressUS.street_address }
    zip        { FFaker::AddressUS.zip_code.to_i }
    phone      { FFaker.numerify('+### ## ### ####') }

    factory :billing_address, class: 'Shopper::BillingAddress'
    factory :shipping_address, class: 'Shopper::ShippingAddress'
  end
end
