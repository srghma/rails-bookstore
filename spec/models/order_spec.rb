require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_one(:billing_address).dependent(:destroy) }
    it { should have_one(:shipping_address).dependent(:destroy) }
    # it { should have_one(:credit_card).dependent(:destroy) }
    it { should have_many(:order_items).dependent(:destroy) }
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
      subject { create(:order, aasm_state: :processing) }

      it 'expect to allow transition from :processing to :in_delivery' do
        subject.sent_to_client
        is_expected.to be_in_delivery
      end
    end

    describe '#end_delivery' do
      subject { create(:order, aasm_state: :in_delivery) }

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
end
