require 'rails_helper'

RSpec.describe CheckoutPage::ValidateStep do
  context 'book exists in current_order' do
    subject { CheckoutPage::ValidateStep.new(current_order, current_step) }

    context 'order doesnt have addresses' do
      let(:current_order) { create :order }
      let(:current_step) { :delivery }

      it 'minimal_accessible_step' do
        subject.send(:minimal_accessible_step).to eq :address
      end
    end
  end
end
