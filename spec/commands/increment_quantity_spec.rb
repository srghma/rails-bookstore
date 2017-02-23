require 'rails_helper'

RSpec.describe CartPage::IncrementQuantity do
  context 'book exists in current_order' do
    let(:order) { create :order, :with_items, number_of_items: 3 }
    subject { CartPage::IncrementQuantity.new(id: 1, by: 100) }

    before do
      caller = double('some controller')
      allow(caller).to receive(:current_order) { order }
      subject.instance_variable_set(:@caller, caller)
    end

    it 'sums quantities' do
      expect { subject.call }.to change {
        order.reload
             .order_items
             .sort_by(&:book_id)
             .collect(&:quantity)
      }.from([1, 1, 1]).to([101, 1, 1])
    end

    it 'dont add new order_item' do
      expect { subject.call }.not_to change {
        order.reload
             .order_items
             .sort_by(&:book_id)
             .collect(&:book_id)
      }
    end

    it 'broadcast ok' do
      expect(subject).to receive(:broadcast).with(:ok)
      subject.call
    end
  end
end
