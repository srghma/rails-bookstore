module CurrentOrderMacros
  def stub_current_order(name)
    allow_any_instance_of(ApplicationController).to receive(:current_order).and_return(order)
  end
end

RSpec.configure do |config|
  config.include CurrentOrderMacros, type: :feature
end
