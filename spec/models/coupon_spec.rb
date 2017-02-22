require 'rails_helper'

RSpec.describe Coupon, type: :model do
  context 'Validation' do
    it { should belong_to(:order) }
  end
end
