require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    it { should validate_presence_of(:email) }
    # TODO: first part of email is case sensitive
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('johndou@gmail.com').for(:email) }
    it { should_not allow_value('johndougmail.com').for(:email) }
  end

  describe 'Associations' do
    it { should have_one(:billing_address).dependent(:destroy) }
    it { should have_one(:shipping_address).dependent(:destroy) }
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:orders).dependent(:nullify) }
  end
end

