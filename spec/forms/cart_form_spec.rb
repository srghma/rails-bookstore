require 'rails_helper'

RSpec.describe CartForm do
  subject { CartForm.from_params(params) }

  context 'valid coupon code' do
    let(:books) { create_list :book, 3 }
    let(:coupon) { create :coupon }

    let(:params) do
      ActionController::Parameters.new(
        'coupon' => { 'code' => coupon.code },
        'products' =>  {
          books[0].id => { 'id' => books[0].id, 'quantity' => '1' },
          books[1].id => { 'id' => books[1].id, 'quantity' => '33' },
          books[2].id => { 'id' => books[2].id, 'quantity' => '1' }
        }
      )
    end

    it 'valid' do
      expect(subject.coupon.code).to eq(coupon.code)
      expect(subject.coupon.code).to be_a(String)
      expect(subject.coupon.valid?).to be true
    end
  end

  context 'invalid coupon code' do
    let(:params) do
      ActionController::Parameters.new('coupon' => { 'code' => 'asdfasf' })
    end

    it 'invalid' do
      expect(subject.coupon.valid?).to be false
      expect(subject.coupon.errors).to be_present
      expect(subject.coupon.errors.messages[:code]).to eq ['is invalid']
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
      product = subject.products.first
      expect(product.valid?).to be false
      expect(product.errors).to be_present
      messages = product.errors.messages
      expect(messages[:base].first).to include "product doesn't exist"
      expect(messages[:quantity].first).to include 'blank'
    end
  end
end
