module AuthenticationGroupMacroses
  def facebook_register_user
    around(:each) do |example|
      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(:facebook, info: {
                                 email: user.email,
                                 first_name: user.first_name,
                                 last_name:  user.last_name
                               })
      visit new_user_registration_path
      first('.general-login-icon').click
      sleep 1
      example.run
      OmniAuth.config.test_mode = false
    end
  end
end

module AuthenticationExampleMacroses
  def fast_register_user(email)
    visit user_fast_path
    within '#quick_registration' do
      fill_in 'user[email]', with: email
    end
    click_button I18n.t('devise.fast.quick_registration.submit')
  end
end

RSpec.configure do |config|
  config.extend AuthenticationGroupMacroses, type: :feature
  config.include AuthenticationExampleMacroses, type: :feature
end
