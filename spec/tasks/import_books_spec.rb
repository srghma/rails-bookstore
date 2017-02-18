require 'rake'

def number_of_books
  Dir.chdir(BookImporter::SEEDS_PATH) do
    return Dir.glob('*').size
  end
end

describe 'bookstore:import_books' do
  include_context 'rake'

  it 'create books and add covers' do
    subject.invoke
    expect(Book.count).to eq number_of_books
    expect(Category.count).to be <= BookImporter::CATEGORY_TITLES.size
  end
end
