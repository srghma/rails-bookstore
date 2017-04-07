RSpec.shared_examples 'addressable' do
  it { should have_one(:billing_address).dependent(:destroy) }
  it { should have_one(:shipping_address).dependent(:destroy) }

  describe 'addresses' do
    subject do
      name = described_class.name.split(':').last.downcase.to_sym
      create name, :with_addresses
    end

    it 'can create and delete addresses' do
      expect(subject.billing_address.type).to eq 'Shopper::BillingAddress'
      subject.billing_address.delete
      subject.reload
      expect(subject.billing_address).to eq nil
      expect(subject.shipping_address).to be_present
      expect(subject.shipping_address.type).to eq 'Shopper::ShippingAddress'
      expect(subject.shipping_address.addressable_type).to eq described_class.name
      expect(subject.shipping_address.addressable).to eq subject
    end
  end
end
