module CurrentOrderMacrosFeature
  def stub_current_order_with(order)
    visit('/')
    create_cookie(CurrentOrder::COOKIE_KEY, order.id)
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
