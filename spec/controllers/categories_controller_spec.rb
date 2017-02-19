require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #show' do
    populate_bookstore(categories_count: 4, books_per_category: 10)

    let(:current_order_method) { subject.presenter.instance_variable_get(:@current_order_method) }

    context 'categories' do
      context 'valid request' do
        before { get :show }

        it 'use default order' do
          expect(@responce).to render_template :show
          expect(flash).to be_empty
          expect(current_order_method).to eq :by_creation_date
        end
      end

      context 'invalid order' do
        before { get :show, params: { order: 'shakalaka' } }

        it 'use default order and show notice flash' do
          expect(@responce).to render_template :show
          expect(flash[:error]).to eq 'Invalid order'
          expect(current_order_method).to eq :by_creation_date
        end
      end

      context 'specific order' do
        before { get :show, params: { order: :by_title } }

        it 'use order' do
          expect(@responce).to render_template :show
          expect(flash).to be_empty
          expect(current_order_method).to eq :by_title
        end
      end
    end

    context 'specific category' do
      context 'valid request' do
        before { get :show, params: { id: 1 } }

        it 'show books in category' do
          expect(@responce).to render_template :show
          expect(flash).to be_empty
          expect(current_order_method).to eq :by_creation_date
        end
      end

      context 'invalid category' do
        before { get :show, params: { id: 100 } }

        it 'redirect to categories' do
          expect(@responce).to redirect_to(categories_path)
          expect(flash[:error]).to eq 'Invalid category'
        end
      end
      context 'invalid order' do
        before { get :show, params: { id: 1, order: 'asdfasf' } }

        it 'use default order and show notice flash' do
          expect(@responce).to render_template :show
          expect(flash[:error]).to eq 'Invalid order'
          expect(current_order_method).to eq :by_creation_date
        end
      end

      context 'specific order' do
        before { get :show, params: { id: 1, order: :by_popularity } }

        it 'use order' do
          expect(@responce).to render_template :show
          expect(flash).to be_empty
          expect(current_order_method).to eq :by_popularity
        end
      end
    end
  end
end