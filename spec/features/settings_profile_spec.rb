feature 'Settings profile page:' do
  it 'dont pass guests' do
    visit settings_profile_path
    expect(page).to have_current_path new_user_session_path
  end

  context 'email' do
    let!(:user) { create :user }

    before { sign_in user }
    before { visit settings_profile_path }

    it 'change email' do
      new_email = 'whatismyname@valid.com'

      within '#edit_email' do
        fill_in 'user[email_form][email]', with: new_email
        click_on 'Save'
      end
      expect(page).to have_current_path settings_profile_path
      expect(user.reload.email).to eq new_email
    end

    it 'dont change email if invalid' do
      taken_email = create(:user).email
      within '#edit_email' do
        fill_in 'user[email_form][email]', with: taken_email
        click_on 'Save'
      end
      expect(page).to have_current_path settings_profile_path
      expect(page).to have_content 'has already been taken'
    end
  end

  context 'password' do
    let!(:user) { create :user }
    let(:password) { 'secret))))' }

    before { sign_in user }
    before { visit settings_profile_path }

    it 'change password' do
      within '#edit_password' do
        fill_in 'user[password_form][current_password]', with: user.password
        fill_in 'user[password_form][password]', with: password
        fill_in 'user[password_form][password_confirmation]', with: password
        click_on 'Save'
      end
      expect(page).to have_current_path settings_profile_path
      expect(user.reload.valid_password?(password)).to eq true
    end

    it 'dont change password if old invalid' do
      within '#edit_password' do
        fill_in 'user[password_form][current_password]', with: 'shakalaka'
        fill_in 'user[password_form][password]', with: password
        fill_in 'user[password_form][password_confirmation]', with: password
        click_on 'Save'
      end
      expect(page).to have_current_path settings_profile_path
      expect(page).to have_content 'is invalid'
      expect(user.reload.valid_password?(password)).to eq false
    end
  end

  context 'fast authenticated user' do
    let(:attrs) { attributes_for(:user) }
    let(:email) { attrs[:email] }
    let(:password) { attrs[:password] }

    before { fast_register_user(attrs[:email]) }
    before { visit settings_profile_path }

    it 'no need to confirm password' do
      within '#edit_password' do
        fill_in 'user[password_form][password]', with: password
        fill_in 'user[password_form][password_confirmation]', with: password
        click_on 'Save'
      end
      expect(page).to have_current_path settings_profile_path

      valid = User.find_by(email: email).valid_password?(password)
      expect(valid).to eq true
    end
  end

  context 'delete me' do
    let(:user) { create :user }
    before { sign_in user }
    before { visit settings_profile_path }

    it 'delete user' do
      click_checkbox
      page.execute_script("$('#remove_account_btn').click()")
      expect(page).to have_current_path root_path
      expect(User.exists?(user.id)).to be false
    end
  end
end
