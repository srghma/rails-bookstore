feature 'Home page' do
  scenario 'first visit' do
    visit '/'
    expect(page).to have_current_path '/'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Sign up'
  end

  scenario 'signed user visit', authenticated: true do
    visit '/'
    expect(page).to have_current_path '/'
    expect(page).to have_content 'My account'
  end
end
