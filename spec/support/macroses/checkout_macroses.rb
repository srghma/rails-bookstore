module CheckoutMacroses
  def fill_address(type, address, country)
    fill_in "order[#{type}][first_name]", with: address[:first_name]
    fill_in "order[#{type}][last_name]",  with: address[:last_name]
    fill_in "order[#{type}][street]",     with: address[:street]
    fill_in "order[#{type}][city]",       with: address[:city]
    find(:css, "#order_#{type}_country_id").select(country.name)
    fill_in "order[#{type}][zip]",        with: address[:zip]
    fill_in "order[#{type}][phone]",      with: address[:phone]
  end

  def fill_payment(credit_card)
    fill_in 'Number', with: credit_card[:number]
    find('.months-select').select('March')
    fill_in 'Expiration year', with: credit_card[:expiration_year]
    fill_in 'Cvv', with: credit_card[:cvv]
  end
end

RSpec.configure do |config|
  config.include CheckoutMacroses, type: :feature
end
