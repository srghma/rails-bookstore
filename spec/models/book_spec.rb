require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'Validation' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    # TODO: shoulda bug, wait
    # it { should validate_numericality_of(:price) }
    it { should validate_length_of(:description).is_at_most(500) }
  end

  context 'Associations' do
    it { should belong_to(:category) }
    it { should have_many(:authors).through(:authorships) }
    # it { should have_many(:reviews).dependent(:destroy) }
    # it { should have_many(:order_items).dependent(:destroy) }
    # it { should have_many(:wishes).dependent(:destroy) }
  end

  context '#cover' do
    context 'when empty' do
      let(:book) { create :book }

      it 'should provide default image url' do
        expect(book.cover.class).to eq BookCoverUploader
        expect(book.cover.url).to eq ''
      end
    end

    context 'when non empty' do
      let(:book) { create :book, cover: 'my_file.png' }

      it 'should provide image url' do
        book = create :book
        expect(book.cover.url).to eq ''
      end
    end
  end
end
