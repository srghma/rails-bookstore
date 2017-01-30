require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  it { expect(ShippingAddress.superclass).to eq(Address) }
end
