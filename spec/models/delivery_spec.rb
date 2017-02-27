require 'rails_helper'

RSpec.describe Delivery, type: :model do
  describe 'Associations' do
    it { should have_many(:orders) }
  end

  describe 'Validation' do
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:min_days) }
    it { should validate_presence_of(:max_days) }

    it 'min days < max_days' do
      subject = create(:delivery)
      expect(subject.valid?).to eq true

      subject.min_days = 1
      subject.max_days = 1
      expect(subject.valid?).to eq true

      subject.min_days = 3
      subject.max_days = 1
      expect(subject.valid?).to eq false
    end
  end
end
