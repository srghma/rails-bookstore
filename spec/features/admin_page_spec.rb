feature 'Admin page' do
  scenario 'first visit' do
    visit root_path
    expect(page).to have_current_path root_path
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Sign up'
  end

  context 'user exists in database' do
    let(:user) { create :user }

    scenario 'signed user visit', authenticated: true do
      visit root_path
      expect(page).to have_current_path root_path
      expect(page).to have_content 'My account'
    end
  end
end
