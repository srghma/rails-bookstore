feature 'Admin page:' do
  context 'when ordinary user' do
    mock_sign_in :user

    scenario 'cannot visit' do
      visit rails_admin_path
      expect(current_path).to eq rails_admin_path
    end
  end

  context 'when admin' do
    mock_sign_in :admin

    scenario 'can visit' do
      visit root_path
      expect(page).to have_current_path root_path
      expect(page).to have_content 'My account'
    end
  end
end
