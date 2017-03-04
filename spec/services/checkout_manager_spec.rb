require 'rails_helper'

RSpec.describe CheckoutManager do
  context '#minimal_accessible_step_index' do
    subject { CheckoutManager.new(nil, nil) }

    before do
      expect(subject).to receive(:steps_with_completeness) { {
        address:  true,
        delivery: true,
        payment:  false,
        confirm:  true,
        complete: false
      } }
    end

    it '..' do
      expect(subject.send(:minimal_accessible_step_index)).to eq 2
    end
  end

  context '#minimal_accessible_step' do
    subject do
      CheckoutManager.new(order, nil)
                     .method(:minimal_accessible_step)
    end

    context 'order doesnt have addresses' do
      let(:order) { create :order }

      it 'return :addresses' do
        expect(subject.call).to eq :address
      end
    end

    context 'order doesnt have addresses' do
      let(:order) { create :order, :with_addresses }

      it 'return :addresses' do
        expect(subject.call).to eq :delivery
      end
    end
  end

  context '#can_access?' do
    context 'user doesnt fill anything' do
      let(:order) { create :order }

      {
        address:  true,
        delivery: false,
        payment:  false,
        confirm:  false,
        complete: false
      }.each do |step, expectation|
        send :it, "with #{step} should return #{expectation}" do
          expect(CheckoutManager.new(order, step).can_access?).to eq expectation
        end
      end
    end

    context 'user fill addresses' do
      let(:order) { create :order, :with_addresses }

      {
        address:  true,
        delivery: true,
        payment:  false,
        confirm:  false,
        complete: false
      }.each do |step, expectation|
        send :it, "with #{step} should return #{expectation}" do
          expect(CheckoutManager.new(order, step).can_access?).to eq expectation
        end
      end
    end

    context 'user fill addresses and delivery' do
      let(:order) { create :order, :with_addresses, :with_delivery }

      {
        address:  true,
        delivery: true,
        payment:  true,
        confirm:  false,
        complete: false
      }.each do |step, expectation|
        send :it, "with #{step} should return #{expectation}" do
          expect(CheckoutManager.new(order, step).can_access?).to eq expectation
        end
      end
    end

    context 'user fill addresses and delivery and credit_card' do
      let(:order) { create :order, :with_addresses, :with_delivery, :with_credit_card }

      {
        address:  true,
        delivery: true,
        payment:  true,
        confirm:  true,
        complete: false
      }.each do |step, expectation|
        send :it, "with #{step} should return #{expectation}" do
          expect(CheckoutManager.new(order, step).can_access?).to eq expectation
        end
      end
    end
  end
end
