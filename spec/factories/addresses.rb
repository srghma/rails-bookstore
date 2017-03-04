FactoryGirl.define do
  factory :address, class: 'Address', aliases: [:addressable] do
    country
    first_name { FFaker::Name.first_name }
    last_name  { FFaker::Name.last_name }
    city       { FFaker::AddressUS.city }
    street     { FFaker::AddressUS.street_address }
    zip        { FFaker::AddressUS.zip_code.to_i }
    phone      { FFaker.numerify('+### ## ### ####') }

    factory :billing_address, class: 'BillingAddress' do
      association :addressable, factory: :address
    end

    factory :shipping_address, class: 'ShippingAddress' do
      association :addressable, factory: :address
    end
  end
end
