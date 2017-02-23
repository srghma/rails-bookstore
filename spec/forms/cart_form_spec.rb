require 'rails_helper'

RSpec.describe CartForm do
  subject { CartForm.from_params(params) }

  context 'valid coupon code' do
    let(:books) { create_list :book, 3 }
    let(:coupon) { create :coupon }

    let(:params) do
      ActionController::Parameters.new(
        'coupon_code' => coupon.code,
        'products' =>  {
          books[0].id => { 'id' => books[0].id, 'quantity' => '1' },
          books[1].id => { 'id' => books[1].id, 'quantity' => '33' },
          books[2].id => { 'id' => books[2].id, 'quantity' => '1' }
        }
      )
    end

    it 'valid' do
      expect(subject.coupon_code).to eq(coupon.code)
      expect(subject.coupon_code).to be_a(String)
      expect(subject.valid?).to be true
    end
  end

  context 'invalid coupon code' do
    let(:params) do
      ActionController::Parameters.new('coupon_code' => 'asdfasf')
    end

    it 'invalid' do
      expect(subject.valid?).to be false
      expect(subject.errors).to be_present
      expect(subject.errors.messages[:coupon_code]).to eq ['is invalid']
    end
  end

  context 'invalid product' do
    let(:params) do
      ActionController::Parameters.new(
        'products' =>  {
          'valid_id' => { 'id' => 'invalid_id', 'quantity' => '' }
        }
      )
    end

    it 'invalid' do
      expect(subject.coupon_code).to be nil
      expect(subject.valid?).to be false
      expect(subject.errors).to be_present
      first_product_messages = subject.products.first.errors.messages
      expect(first_product_messages[:base].first).to include "product doesn't exist"
      expect(first_product_messages[:quantity].first).to include 'blank'
    end
  end
end
