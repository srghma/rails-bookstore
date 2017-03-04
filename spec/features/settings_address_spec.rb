feature 'Settings address page:' do
  populate_bookstore

  it 'dont pass guests' do
    visit settings_address_path
    expect(page).to have_current_path new_user_registration_path
  end

  context 'when signed' do
    before { sign_in create(:user) }

    scenario 'signed user visit' do
      visit root_path
      expect(page).to have_current_path root_path
      expect(page).to have_content 'My account'
    end
  end
end
