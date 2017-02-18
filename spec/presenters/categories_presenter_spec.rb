require 'rails_helper'

RSpec.describe CategoriesPresenter do
  populate_bookstore
  subject { CategoriesPresenter.new }

  context '#order_methods' do
    before do
      allow(subject).to receive(:params).and_return(params)
    end

    context 'params specified' do
      let(:params) { { order: 'by_title' } }

      it 'should return order methods with current on top' do
        expect(subject.current_order).to  eq 'Title: A-Z'
      end
    end

    context 'params invalid' do
      let(:params) { { sort: 'asdfa' } }

      it 'should return order methods' do
        expect(subject.current_order).to  eq 'Newest first'
      end
    end
  end
end
