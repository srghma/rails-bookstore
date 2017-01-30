require 'rails_helper'

RSpec.describe Author, type: :model do
  context 'Validation' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  context 'Association' do
    it { should have_many(:books).through(:authorships) }
  end

  context 'Before save' do
    subject { create(:author, first_name: 'john', last_name: 'dou') }

    it 'should capitalize #first_name' do
      expect(subject.first_name).to eq 'John'
    end

    it 'should capitalize #last_name' do
      expect(subject.last_name).to eq 'Dou'
    end
  end

  describe '#to_s' do
    it 'should return #first_name + #last_name' do
      expect(subject.to_s).to eq("#{subject.first_name} #{subject.last_name}")
    end
  end
end
