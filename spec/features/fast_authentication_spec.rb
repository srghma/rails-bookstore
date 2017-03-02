feature 'Fast authentication:' do
  before do
    visit checkout_path(:address)
    expect(current_path).to eq user_fast_path
  end

  context 'new customer' do
    let(:user) { attributes_for(:user) }

    before do
      within '#new_user' do
        fill_in 'user[email]', with: email
      end
      click_button I18n.t('devise.fast.new_customer.submit')
    end

    context 'valid params' do
      let(:email) { user[:email] }

      it 'register user' do
        expect(page.current_path).to eq checkout_path(:address)
        expect(page).to have_content(I18n.t('devise.registrations.signed_up'))
      end
    end

    context 'invalid params' do
      let(:email)    { 'adsf' }

      it 'rerenders page' do
        expect(page.current_path).to eq user_fast_session_path
        form = find('#new_user')
        expect(form.find('.email .help-block').text).to eq 'is invalid'
      end
    end
  end

  context 'old customer' do
    let(:user) { create(:user) }

    before do
      within '#new_session' do
        fill_in 'user[email]',    with: email
        fill_in 'user[password]', with: password
      end
      click_button I18n.t('devise.fast.old_customer.submit')
    end

    context 'valid params' do
      let(:email)    { user.email }
      let(:password) { user.password }

      it 'sign in user' do
        expect(page.current_path).to eq checkout_path(:address)
        expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
      end
    end

    context 'invalid params' do
      let(:email)    { 'adsf' }
      let(:password) { '' }

      it 'rerenders page' do
        expect(page.current_path).to eq user_fast_session_path
        form = find('#new_session')
        expect(form.find('.email .help-block').text).to eq 'is invalid'
        expect(form.find('.password span.help-block').text).to eq "can't be blank"
      end
    end
  end
end