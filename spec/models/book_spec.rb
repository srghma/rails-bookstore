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
    it { should have_and_belong_to_many(:author).join_table(:authors_books) }
    # it { should have_many(:reviews).dependent(:destroy) }
    # it { should have_many(:order_items).dependent(:destroy) }
    # it { should have_many(:wishes).dependent(:destroy) }
  end
end
