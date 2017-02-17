require 'rails_helper'

RSpec.describe CategoriesPresenter do
  populate_bookstore
  subject { CategoriesPresenter.new }

  context '#order_methods' do
    before do
      allow(subject).to receive(:params).and_return(params)
    end

    context 'params specified' do
      let(:params) { { sort: 'by_title' } }

      it 'should return order methods with current on top' do
        keys = subject.order_methods.map(&:key)
        expect(keys.first).to  eq :by_title
        expect(keys.second).to eq :by_creation_date
      end
    end

    context 'params invalid' do
      let(:params) { { sort: 'asdfa' } }

      it 'should return order methods' do
        keys = subject.order_methods.map(&:key)
        expect(keys.first).to  eq :by_creation_date
        expect(keys.second).to eq :by_popularity
      end
    end
  end
end
