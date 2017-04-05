feature 'Fast authentication:' do
  let(:order) { create :order, :with_items }
  before do
    stub_current_order_with(order)
    visit checkout_path(:address)
    expect(current_path).to eq user_fast_path
  end

  context 'quick_registration' do
    let(:user) { attributes_for(:user) }

    before do
      within '#quick_registration' do
        fill_in 'user[email]', with: email
      end
      click_button I18n.t('devise.fast.quick_registration.submit')
    end

    context 'valid params' do
      let(:email) { user[:email] }

      it 'register user' do
        expect(page).to have_current_path checkout_path(:address)
        expect(page).to have_content(I18n.t('devise.registrations.signed_up'))
      end
    end

    context 'invalid params' do
      let(:email)    { 'adsf' }

      it 'rerenders page' do
        expect(page).to have_current_path user_fast_session_path
        form = find('#quick_registration')
        expect(form.find('.email .help-block').text).to eq 'is invalid'
      end
    end
  end

  context 'quick_session' do
    let(:user) { create(:user) }

    before do
      within '#quick_session' do
        fill_in 'user[email]',    with: email
        fill_in 'user[password]', with: password
      end
      click_button I18n.t('devise.fast.quick_session.submit')
    end

    context 'valid params' do
      let(:email)    { user.email }
      let(:password) { user.password }

      it 'sign in user' do
        expect(page).to have_current_path checkout_path(:address)
        expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
      end
    end

    context 'invalid params' do
      let(:email)    { 'adsf' }
      let(:password) { '' }

      it 'rerenders page' do
        expect(page).to have_current_path user_fast_session_path
        expect(page).to have_content 'Invalid email or password'
      end
    end
  end
end
