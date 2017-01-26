require 'rails_helper'

RSpec.describe Admin, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
end
