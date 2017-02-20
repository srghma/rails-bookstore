require 'rails_helper'

RSpec.describe CartController, type: :controller do
  populate_bookstore(categories_count: 4, books_per_category: 10)

  describe 'GET #edit' do
  end

  describe 'GET #add_book' do
    context 'valid params' do
      it 'renders js' do
        post :add_book, params: { id: 1 }, xhr: true
        expect(@responce).to render_template :add_book
      end
    end

    context 'invalid params' do
      it 'dont render js' do
        post :add_book, params: { id: 1 }, xhr: true
        expect(@responce).to redirect_to :root
      end
    end
  end
end
