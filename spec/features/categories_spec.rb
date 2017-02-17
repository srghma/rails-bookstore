feature 'Categories page:' do
  populate_database

  context 'when all categories' do
    before { visit categories_path }

    scenario 'should show page' do
      expect(page).to have_current_path categories_path
      expect(page).to have_content 'All'
    end

    scenario 'can redirect to book' do
      first('.thumb-hover-link').click
      expect(page.current_path).to include 'books'
    end
  end

  context 'when specific category' do
    let(:category) { create(:category) }
    before { visit category_path(category) }

    scenario 'should show page' do
      expect(page).to have_current_path category_path(category)
      expect(page).to have_content category.title
    end
  end
end
