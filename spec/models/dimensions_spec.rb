require 'rails_helper'

RSpec.describe Dimensions do
  context '#to_s' do
    subject { dimensions.to_s }

    context 'when the dimensions are empty' do
      let(:dimensions) { Dimensions.new }

      it 'should return an empty string' do
        expect(subject).to eq ''
      end
    end

    context 'when dimensions have values for all measurments' do
      let(:dimensions) { Dimensions.new(height: 5.375, width: 3, depth: 0.9) }

      it 'should return the height, width, and depth in feet and inches' do
        expect(subject).to eq 'H:5.4′′ × W:3.0′′ × D:0.9′′'
      end
    end

    context 'when dimensions have values for some measurments' do
      let(:dimensions) { Dimensions.new(height: 5.375, width: 3) }

      it 'should return the available height, width, and depth in feet and inches' do
        expect(subject).to eq 'H:5.4′′ × W:3.0′′'
      end
    end
  end
end
