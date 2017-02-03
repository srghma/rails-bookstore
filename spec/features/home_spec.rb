feature 'Home page:' do
  context 'when guest' do
    scenario 'first visit' do
      visit root_path
      expect(page).to have_current_path root_path
      expect(page).to have_content 'Log in'
      expect(page).to have_content 'Sign up'
    end
  end

  context 'when signed' do
    mock_sign_in :user

    scenario 'signed user visit' do
      visit root_path
      expect(page).to have_current_path root_path
      expect(page).to have_content 'My account'
    end
  end
end
