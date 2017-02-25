require 'rails_helper'

RSpec.describe CartController, type: :controller do
  populate_bookstore(categories_count: 4, books_per_category: 10)
  let(:coupon) { create :coupon }
  let(:second_coupon) { create :coupon }

  describe 'GET #update' do
    context 'no current coupon, empty cart' do
      it 'add coupon if it valid' do
        post :update, params: { coupon: { code: coupon.code } }
        expect(subject.current_order.coupon.id).to eq coupon.id
        expect(response).to render_template :edit
      end

      it 'dont add coupon if it invalid' do
        post :update, params: { coupon: { code: 'invalid' } }
        expect(subject.current_order.coupon).to eq nil
        expect(response).to render_template :edit
      end
    end

    context 'exists coupon, cart non empty' do
      before do
        subject.current_order.coupon = coupon
        4.times do |n|
          create :order_item, order: subject.current_order, book: Book.find(n + 1)
        end
      end

      it 'adds valid coupon' do
        post :update, params: { coupon: { code: second_coupon.code } }
        expect(subject.current_order.coupon.id).to eq second_coupon.id
        expect(response).to render_template :edit
      end

      it 'dont add coupon if it invalid' do
        post :update, params: { coupon: { code: 'invalid' } }
        expect(subject.current_order.coupon).to eq coupon
        expect(response).to render_template :edit
      end

      it 'changes book quantity if all params valid' do
        products_params = {
          1 => { 'id' => 1, 'quantity' => '2' },
          3 => { 'id' => 3, 'quantity' => '1' }
        }
        expect do
          post :update, params: { products: products_params, coupon_code: second_coupon.code }
        end.to change {
          subject.current_order
                 .reload
                 .order_items
                 .sort_by(&:book_id)
                 .collect(&:quantity)
        }.from([1, 1, 1, 1]).to([2, 1, 1, 1])
        expect(response).to render_template :edit
      end

      it 'dont change book quality if it invalid' do
        products_params = {
          1 => { 'id' => 1, 'quantity' => '0' },
          3 => { 'id' => 3, 'quantity' => '4' }
        }
        expect do
          post :update, params: { products: products_params }
        end.not_to change {
          subject.current_order
                 .reload
                 .order_items
                 .sort_by(&:book_id)
                 .collect(&:quantity)
        }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'GET #increment_quantity' do
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
