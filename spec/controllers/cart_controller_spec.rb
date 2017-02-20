require 'rails_helper'

RSpec.describe CartController, type: :controller do
  describe 'GET #edit' do
    populate_bookstore(categories_count: 4, books_per_category: 10)

    # before do
    #   create :order
    # end
    let(:current_order_method) { subject.presenter.instance_variable_get(:@current_order_method) }

    context 'categories' do
      context 'valid request' do
        before { get :edit }

        it 'use default order' do
          expect(@responce).to render_template :show
          expect(flash).to be_empty
          expect(current_order_method).to eq :by_creation_date
        end
      end
    end
  end
end
