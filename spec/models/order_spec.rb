require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:delivery) }

    it { should have_one(:billing_address).dependent(:destroy) }
    it { should have_one(:shipping_address).dependent(:destroy) }
    it { should have_one(:credit_card).dependent(:destroy) }
    it { should have_many(:order_items).dependent(:destroy) }
  end

  describe 'addresses' do
    subject { create :order, :with_addresses }
    it 'can create and delete addresses' do
      expect(subject.billing_address.type).to eq 'BillingAddress'
      subject.billing_address.delete
      subject.reload
      expect(subject.billing_address).to eq nil
      expect(subject.shipping_address).to be_present
      expect(subject.shipping_address.type).to eq 'ShippingAddress'
    end
  end

  describe 'States' do
    subject { create :order, :with_items, :with_addresses }

    describe '#queue' do
      it 'expect to allow transition from :in_progress to :processing' do
        subject.queue
        is_expected.to be_processing
      end

      it 'expect to allow transition from :in_progress to :processing' do
        subject.queue
        is_expected.to be_processing
      end

      it 'expect to not allow transition to :processing without billing_address' do
        subject.update(billing_address: nil)
        expect(subject.queue).to be_falsy
      end

      it 'expect to not allow transition to :processing without shipping_address' do
        subject.update(shipping_address: nil)
        expect(subject.queue).to be_falsy
      end
    end

    describe '#sent_to_client' do
      subject { create(:order, state: :processing) }

      it 'expect to allow transition from :processing to :in_delivery' do
        subject.sent_to_client
        is_expected.to be_in_delivery
      end
    end

    describe '#end_delivery' do
      subject { create(:order, state: :in_delivery) }

      it 'expect to allow transition from :in_delivery to :delivered' do
        subject.end_delivery
        is_expected.to be_delivered
      end
    end
  end

  describe '#ready_for_processing?' do
    subject { create(:order, :with_items, :with_addresses) }

    it 'expect to be false without billing address' do
      subject.billing_address = nil
      expect(subject.ready_for_processing?).to be_falsy
    end

    it 'expect to be false without shipping address' do
      subject.shipping_address = nil
      expect(subject.ready_for_processing?).to be_falsy
    end

    # TODO: why not pass
    # it 'expect to be false without order_items' do
    #   OrderItem.destroy_all
    #   subject.order_items.reload
    #   expect(subject.ready_for_processing?).to be_falsy
    # end

    it 'expect to be true with addresses and order_items' do
      expect(subject.ready_for_processing?).to be_truthy
    end
  end

  describe '#create_or_increment_product' do
    let(:product) { create(:book) }
    subject { create :order }

    it 'create order item if item doest exits' do
      item = subject.create_or_increment_product(product.id, 10)
      expect(item).to be_persisted
      expect(item.quantity).to eq 10
    end

    it 'increment item quantity if item exits' do
      subject.order_items.create(book: product, quantity: 1)
      item = subject.create_or_increment_product(product.id, 10)
      expect(item).to be_persisted
      expect(item.quantity).to eq 11
    end

    it 'return false if invalid product' do
      item = subject.create_or_increment_product(1000, 10)
      expect(item).to eq false
    end
  end


  describe '#create_or_update_product' do
    let(:product) { create(:book) }
    subject { create :order }

    it 'create order item if item doest exits' do
      item = subject.create_or_update_product(product.id, 10)
      expect(item).to be_persisted
      expect(item.quantity).to eq 10
    end

    it 'increment item quantity if item exits' do
      subject.order_items.create(book: product, quantity: 1)
      item = subject.create_or_update_product(product.id, 10)
      expect(item).to be_persisted
      expect(item.quantity).to eq 10
    end

    it 'return false if invalid product' do
      # TODO: why last is nil, but not after reload
      # item = subject.create_or_update_product(Book.last.id + 1, 10)
      item = subject.create_or_update_product(1000, 10)
      expect(item).to eq false
    end
  end
end
