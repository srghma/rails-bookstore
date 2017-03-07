require 'rails_helper'

RSpec.describe CartController, type: :controller do
  populate_bookstore(categories_count: 4, books_per_category: 10)
  let(:coupon) { create :coupon }
  let(:second_coupon) { create :coupon }

  describe 'GET #add_product' do
    context 'valid params' do
      it 'renders js' do
        expect do
          post :add_product, params: { id: 1 }, xhr: true
        end.to change { OrderItem.count }.by(1)

        expect(response).to render_template :add_product
      end
    end

    context 'invalid params' do
      it 'redirect via js' do
        expect do
          post :add_product, params: { id: 300 }, xhr: true
        end.not_to change { OrderItem.count }

        expect(response.body).to include 'Turbolinks.visit("http://test.host'
      end
    end
  end
end
