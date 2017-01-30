require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_one(:billing_address).dependent(:destroy) }
    it { should have_one(:shipping_address).dependent(:destroy) }
    # it { should have_one(:credit_card).dependent(:destroy) }
    it { should have_many(:order_items).dependent(:destroy) }
  end
end
