require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'Validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price) }
    it { should validate_length_of(:description).is_at_most(500) }
  end

  context 'Associations' do
    it { should belong_to(:category) }
    it { should have_many(:authors).through(:authorships) }
    it { should have_many(:order_items).dependent(:destroy) }
  end

  context '#cover_url_or_default' do
    subject { create(:book).method(:cover_url_or_default) }

    context 'when empty' do
      it 'should provide fallback image url' do
        expect(subject.call).to include '/fallback/cover_default'
      end

      it 'should provide thumb fallback image url' do
        expect(subject.call(version: :thumb)).to include '/fallback/thumb_cover_default'
      end
    end

    context 'when non empty' do
      let(:book) { create(:book, :with_cover, number_of_covers: 4).method(:cover_url_or_default) }

      it 'should provide image url' do
        expect(subject.call).to include 'cover_default'
      end

      it 'should provide thumb image url' do
        expect(subject.call(version: :thumb)).to include 'thumb_cover_default'
      end
    end
  end
end
