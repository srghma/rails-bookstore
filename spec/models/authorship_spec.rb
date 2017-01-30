require 'rails_helper'

RSpec.describe Authorship, type: :model do
  context 'Validation' do
    it { should validate_presence_of(:book) }
    it { should validate_presence_of(:author) }
  end
end
