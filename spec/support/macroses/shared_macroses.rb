module SharedMacroses
  def fill_address(addressable, type, address, country)
    fill_in "#{addressable}[#{type}][first_name]", with: address[:first_name]
    fill_in "#{addressable}[#{type}][last_name]",  with: address[:last_name]
    fill_in "#{addressable}[#{type}][street]",     with: address[:street]
    fill_in "#{addressable}[#{type}][city]",       with: address[:city]
    find(:css, "##{addressable}_#{type}_country_id").select(country.name)
    fill_in "#{addressable}[#{type}][zip]",        with: address[:zip]
    fill_in "#{addressable}[#{type}][phone]",      with: address[:phone]
  end

  def fill_card(card)
    fill_in 'order[card][number]',          with: card[:number]
    fill_in 'order[card][name]',            with: card[:name]
    fill_in 'order[card][expiration_date]', with: card[:expiration_date]
      .strftime(Shopper::CreditCardForm::DATE_FORMAT)
    fill_in 'order[card][cvv]',             with: card[:cvv]
  end

  def click_checkbox
    find('.checkbox-icon').click
  end

  def reload_page
    sleep 0.1 if Capybara.current_driver == :poltergeist
    page.evaluate_script('window.location.reload()')
  end
end

RSpec.configure do |config|
  config.include SharedMacroses, type: :feature
end
