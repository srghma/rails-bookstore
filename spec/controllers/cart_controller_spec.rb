require 'rails_helper'

RSpec.describe CartController, type: :controller do
  populate_bookstore(categories_count: 4, books_per_category: 10)

  describe 'GET #edit' do
  end

  describe 'GET #add_product' do
    context 'valid params' do
      it 'renders js' do
        post :add_product, params: { type: 'bOOk', id: 1 }, xhr: true
        expect(@responce).to render_template :add_product
      end
    end

    context 'invalid params' do
      it 'dont render js' do
        post :add_product, params: { type: 'cattle', id: 1 }, xhr: true
        expect(@responce).to redirect_to :root
      end
    end
  end
end
