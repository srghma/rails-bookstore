module CurrentOrderMacrosFeature
  def stub_current_order_with(order)
    # selenium cant set cookie without page, poltergeist - vice versa
    visit('/') if Capybara.current_driver == :selenium_chrome
    create_cookie(Shopper::CurrentOrder::KEY, order.id)
  end
end

module CurrentOrderMacrosController
  def stub_current_order_with(order)
    allow_any_instance_of(ApplicationController).to receive(:current_order).and_return(order)
  end
end

RSpec.configure do |config|
  config.include CurrentOrderMacrosFeature, type: :feature
  config.include CurrentOrderMacrosController, type: :controller
end
