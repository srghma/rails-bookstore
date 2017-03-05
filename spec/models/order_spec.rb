require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:delivery) }

    it { should have_one(:credit_card).dependent(:destroy) }
    it { should have_many(:order_items).dependent(:destroy) }
  end
  it { should have_db_column(:use_billing) }

  it_behaves_like 'addressable'

  describe '#generate_number' do
    it '...' do
      number = Order.create.number
      expect(number).to start_with('#R')
      expect(number.length).to eq 10
    end
  end

  describe 'States' do
    subject { create :order, :with_items, :with_addresses }

    describe '#place_order' do
      it 'expect to allow transition from :in_progress to :processing' do
        subject.place_order
        is_expected.to be_processing
      end

      it 'expect to allow transition from :in_progress to :processing' do
        subject.place_order
        is_expected.to be_processing
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
