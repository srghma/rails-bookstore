feature 'Authentication' do
  context 'user exists in database' do
    let(:user) { create :user }

    context 'log in' do
      before { visit new_user_session_path }

      scenario 'ordinary' do
        within('.general-form') do
          fill_in 'Enter Email', with: user.email
          fill_in 'Password',    with: user.password
        end
        click_button 'Log in'
        expect(current_path).to eq root_path
      end

      scenario 'wrong password' do
        within('.general-form') do
          fill_in 'Enter Email', with: user.email
          fill_in 'Password',    with: 'wrong'
        end
        click_button 'Log in'
        expect(page).to have_content 'Invalid Email or password'
      end
    end
  end

  context 'user doesnt exists in database' do
    let(:user) { build :user }

    context 'sing up' do
      before { visit new_user_registration_path }

      scenario 'ordinary' do
        within('.general-form') do
          fill_in 'Enter Email',      with: user.email
          fill_in 'Password',         with: user.password, match: :prefer_exact
          fill_in 'Confirm Password', with: user.password, match: :prefer_exact
        end
        click_button 'Sign up'
        expect(current_path).to eq root_path
      end
    end

    scenario 'with facebook', facebook_mock: true do
      visit new_user_registration_path
      first('.general-login-icon').click
      sleep 1
      expect(current_path).to eq root_path
    end
  end
end
