feature 'Authentication:' do
  context 'when user exists in database' do
    let(:user) { create :user }

    context 'when log in' do
      before { visit new_user_session_path }

      scenario 'ordinary' do
        within('.general-form') do
          fill_in 'Enter Email', with: user.email
          fill_in 'Password',    with: user.password
        end
        click_button 'Log in'
        expect(current_path).to eq root_path
        get_confirm_email(user.email)
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

  context 'when user doesnt exists in database' do
    let(:user) { build :user }

    scenario 'ordinary' do
      visit new_user_registration_path
      within('.general-form') do
        fill_in 'Enter Email',      with: user.email
        fill_in 'Password',         with: user.password, match: :prefer_exact
        fill_in 'Confirm Password', with: user.password, match: :prefer_exact
        find('input[type="submit"]').click
      end
      expect(current_path).to eq root_path
    end
  end

  context 'facebook registered' do
    let(:user) { build :user }
    facebook_register_user

    scenario 'with facebook' do
      expect(current_path).to eq root_path
    end
  end
end
