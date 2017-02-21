require 'rails_helper'

RSpec.describe CartController, type: :controller do
  populate_bookstore(categories_count: 4, books_per_category: 10)

  describe 'GET #edit' do
  end

  describe 'GET #add_book' do
    context 'valid params' do
      it 'renders js' do
        expect do
          post :add_book, params: { id: 1 }, xhr: true
        end.to change { OrderItem.count }.by(1)

        expect(response).to render_template :add_book
      end
    end

    context 'invalid params' do
      it 'redirect via js' do
        expect do
          post :add_book, params: { id: 300 }, xhr: true
        end.not_to change { OrderItem.count }

        expect(response.body).to include 'Turbolinks.visit("http://test.host'
      end
    end
  end
end
