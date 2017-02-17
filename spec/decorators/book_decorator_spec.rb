require 'rails_helper'

RSpec.describe BookDecorator do
  subject { BookDecorator.new(book) }

  context '#cover_url' do
    context 'when empty' do
      let(:book) { create :book }

      it 'should provide fallback image url' do
        expect(subject.cover_url).to include '/fallback/cover_default'
      end

      it 'should provide thumb fallback image url' do
        expect(subject.cover_url(version: :thumb)).to include '/fallback/thumb_cover_default'
      end
    end

    context 'when non empty' do
      let(:book) { create :book, :with_cover, number_of_covers: 4 }

      it 'should provide image url' do
        expect(subject.cover_url).to include 'image_example'
      end

      it 'should provide thumb image url' do
        expect(subject.cover_url(version: :thumb)).to include 'thumb_image_example'
      end
    end
  end
end
