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
    context 'when user in database' do
      it 'should return user' do
        user = create :user, :facebook_registered
        auth = double('Auth', provider: 'facebook', uid: 1)
        expect(User.from_omniauth(auth)).to eq(user)
      end
    end

    context 'when user not in database' do
      it 'should create new user from info' do
        info = double('Info', email: FFaker::Internet.email)
        auth = double('Auth', provider: 'facebook', uid: 1, info: info)

        expect do
          User.from_omniauth(auth)
        end.to change { User.count }.by(1)
      end
    end
  end
end
