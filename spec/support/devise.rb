RSpec.shared_context 'authorized' do
  let(:user) { create :user }

  before do
    sign_in user, scope: :user
  end
end

RSpec.configure do |config|
  # config.include Devise::Test::ControllerHelpers, type: :controller
  # config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::Test::IntegrationHelpers, type: :feature

  config.include_context 'authorized', authorized: true
end
