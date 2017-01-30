require 'rails_helper'

RSpec.describe BillingAddress, type: :model do
  it { expect(BillingAddress.superclass).to eq(Address) }
end
