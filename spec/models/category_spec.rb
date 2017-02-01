require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'Validation' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).case_insensitive }
  end

  context 'Associations' do
    it { should have_many(:books) }
  end
end
