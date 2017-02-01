RSpec.shared_context 'authenticated' do
  let(:user) { create :user }

  before(:each) do
    sign_in user, scope: :user
  end
end

RSpec.shared_context 'facebook_mock' do
  let(:user) { create :user }

  around(:each) do |example|
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:facebook, info: { email: user.email })
    example.run
    OmniAuth.config.test_mode = false
  end
end

RSpec.configure do |config|
  config.include_context 'authenticated', authenticated: true
  config.include_context 'facebook_mock', facebook_mock: true
end
