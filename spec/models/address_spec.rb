require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'Validation' do
    it { should validate_presence_of(:country) }

    # it { should validate_presence_of(:first_name) }
    # it { should validate_presence_of(:last_name) }
    # it { should validate_presence_of(:city) }
    # it { should validate_presence_of(:street) }
    # it { should validate_presence_of(:phone) }
    # it { should validate_presence_of(:zip) }
    # it { should validate_numericality_of(:zip) }
    # it { should allow_value('+333 33 333 3333').for(:phone) }
    # it { should_not allow_value('333 33 333 3333').for(:phone) }
    # it { should_not allow_value('+333-33-333-3333').for(:phone) }
    # it { should_not allow_value('saasdfdf').for(:phone).with_message('Please enter phone number in format +355 66 123 4567') }
  end

  describe 'Associations' do
    it { should belong_to(:country) }
    it { should belong_to(:user) }
    it { should belong_to(:order) }
  end
end
