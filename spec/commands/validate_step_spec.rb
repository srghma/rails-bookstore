require 'rails_helper'

RSpec.describe CheckoutPage::ValidateStep do
  context '#minimal_accessible_step_index' do
    subject { CheckoutPage::ValidateStep.new(nil, nil) }
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
      CheckoutPage::ValidateStep.new(current_order, nil)
                                .method(:minimal_accessible_step)
    end

    context 'order doesnt have addresses' do
      let(:current_order) { create :order }

      it 'return :addresses' do
        expect(subject.call).to eq :address
      end
    end

    context 'order doesnt have addresses' do
      let(:current_order) { create :order, :with_addresses }

      it 'return :addresses' do
        expect(subject.call).to eq :delivery
      end
    end
  end

  context '#can_access?' do
    subject do
      CheckoutPage::ValidateStep.new(current_order, nil)
                                .method(:can_access?)
    end

    context 'user doesnt fill anything' do
      let(:current_order) { create :order }

      {
        address:  true,
        delivery: false,
        payment:  false,
        confirm:  false,
        complete: false
      }.each do |step, expectation|
        send :it, "with #{step} should return #{expectation}" do
          expect(subject.call(step)).to eq expectation
        end
      end
    end

    context 'user fill addresses' do
      let(:current_order) { create :order, :with_addresses }

      {
        address:  true,
        delivery: true,
        payment:  false,
        confirm:  false,
        complete: false
      }.each do |step, expectation|
        send :it, "with #{step} should return #{expectation}" do
          expect(subject.call(step)).to eq expectation
        end
      end
    end

    context 'user fill addresses and delivery' do
      let(:current_order) { create :order, :with_addresses, :with_delivery }

      {
        address:  true,
        delivery: true,
        payment:  true,
        confirm:  false,
        complete: false
      }.each do |step, expectation|
        send :it, "with #{step} should return #{expectation}" do
          expect(subject.call(step)).to eq expectation
        end
      end
    end

    context 'user fill addresses and delivery and credit_card' do
      let(:current_order) { create :order, :with_addresses, :with_delivery, :with_credit_card }

      {
        address:  true,
        delivery: true,
        payment:  true,
        confirm:  true,
        complete: false
      }.each do |step, expectation|
        send :it, "with #{step} should return #{expectation}" do
          expect(subject.call(step)).to eq expectation
        end
      end
    end
  end
end
