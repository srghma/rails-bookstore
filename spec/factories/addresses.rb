FactoryGirl.define do
  factory :address, aliases: [:addressable] do
    # TODO: country_code "MyString"
    first_name { FFaker::Name.first_name }
    last_name  { FFaker::Name.last_name }
    city       { FFaker::Address.city }
    street     { FFaker::Address.street_address }
    zip        { FFaker::Address.zip.to_i }
    phone      { FFaker::Base.numerify('+##########') }

    factory :shipping_address do
      addressable
    end

    factory :billing_address do
      addressable
    end
  end
end
