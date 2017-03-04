module CurrentOrderMacros
  def stub_current_order_with(order)
    # TODO: if only there was a way to set @current_order_id to ApplContr instance directly
    visit('/')
    create_cookie(CurrentOrder::COOKIE_KEY, order.id)
  end
end

RSpec.configure do |config|
  config.include CurrentOrderMacros, type: :feature
end
