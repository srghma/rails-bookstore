require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'Associations' do
    it { should belong_to(:order) }
    it { should belong_to(:book) }
  end

  describe 'Validation' do
    it { should validate_presence_of(:order) }
    it { should validate_presence_of(:book) }
    it { should validate_presence_of(:quantity) }

    it { should validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(1) }
  end
end
