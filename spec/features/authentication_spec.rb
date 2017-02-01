feature 'Authentication' do
  scenario 'ordinary log in' do
    user = create :user
    visit new_user_session_path
    within('.general-form') do
      fill_in 'Enter Email', with: user.email
      fill_in 'Password',    with: user.password
    end
    click_button 'Sign in'
    expect(current_path).to eq root_path
  end

  scenario 'facebook log in', facebook_mock: true do
    visit new_user_session_path
    click_button '.general-login-icon'
    expect(current_path).to eq root_path
  end
end
