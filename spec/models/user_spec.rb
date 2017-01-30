require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('johndou@gmail.com').for(:email) }
    it { should_not allow_value('johndougmail.com').for(:email) }
  end

  describe 'Associations' do
    it { should have_one(:billing_address).dependent(:destroy) }
    it { should have_one(:shipping_address).dependent(:destroy) }
    # it { should have_many(:reviews).dependent(:destroy) }
    # it { should have_many(:orders).dependent(:nullify) }
  end

  describe '.from_omniauth' do
    let(:email) { FFaker::Internet.email }
    let(:info) { double('Info', email: email) }
    let(:auth) { double('Auth', info: info) }

    context 'when user in database' do
      it 'should return user' do
        user = create :user, email: email
        expect(User.from_omniauth(auth)).to eq(user)
      end
    end

    context 'when user not in database' do
      it 'should create new user from info' do
        expect do
          User.from_omniauth(auth)
        end.to change { User.count }.by(1)
      end
    end
  end
end
