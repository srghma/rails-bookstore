feature 'Book page:' do
  let(:book) { create :book, :with_cover }
  before { visit book_path(book) }

  scenario 'sould show page' do
    expect(page).to have_current_path book_path(book)
  end
end
