module SharedMacroses
  def fill_address(type, address, country)
    fill_in "order[#{type}][first_name]", with: address[:first_name]
    fill_in "order[#{type}][last_name]",  with: address[:last_name]
    fill_in "order[#{type}][street]",     with: address[:street]
    fill_in "order[#{type}][city]",       with: address[:city]
    find(:css, "#order_#{type}_country_id").select(country.name)
    fill_in "order[#{type}][zip]",        with: address[:zip]
    fill_in "order[#{type}][phone]",      with: address[:phone]
  end

  def fill_card(card)
    fill_in 'order[card][number]',          with: card[:number]
    fill_in 'order[card][name]',            with: card[:name]
    fill_in 'order[card][expiration_date]', with: card[:expiration_date]
      .strftime(CreditCardForm::DATE_FORMAT)
    fill_in 'order[card][cvv]',             with: card[:cvv]
  end

  def click_checkbox
    case Capybara.default_driver
    when :selenium_chrome
      find('.checkbox-icon').click
    when :webkit
      find('.checkbox-icon').trigger('click')
    end
  end
end

RSpec.configure do |config|
  config.include SharedMacroses, type: :feature
end
