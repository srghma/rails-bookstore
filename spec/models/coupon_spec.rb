require 'rails_helper'

RSpec.describe Coupon, type: :model do
  context 'Validation' do
    it { should belong_to(:order) }
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:discount) }
  end
end
