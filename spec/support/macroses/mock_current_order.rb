module CurrentOrderMacros
  def mock_current_order(with:)
    before do
      order = send(with)
      allow_any_instance_of(ApplicationController).to receive(:current_order).and_return(order)
    end
  end
end

RSpec.configure do |config|
  config.extend CurrentOrderMacros, type: :feature
end
