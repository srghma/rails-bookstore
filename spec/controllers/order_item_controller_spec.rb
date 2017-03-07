require 'rails_helper'

RSpec.describe OrderItemController, type: :controller do
  describe '#destroy' do
    it 'destroy if authorized' do
      order = create :order, :with_items
      stub_current_order_with(order)
      item = order.order_items.first
      expect do
        delete :destroy, params: { id: item.id }
      end.to change { OrderItem.count }.by(-1)
    end

    it 'dont destory if doesnt belongs to current order' do
      item = create :order_item
      expect do
        delete :destroy, params: { id: item.id }
        expect(response).to redirect_to cart_path
      end.not_to change { OrderItem.count }
    end
  end
end
