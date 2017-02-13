module BookImporter
  SEEDS_PATH = Rails.root.join('db', 'book_seeds')

  class << self
    def import
      import_directory(SEEDS_PATH)
    end

    def import_directory(path)
      Dir.chdir(path) do
        Dir.glob('*').each do |entry|
          entry = path.join(entry)
          File.directory?(entry) ? import_directory(entry) : create_book_with_cover(entry)
        end
      end
    end

    def create_book_with_cover(cover_path)
      dirname = cover_path.dirname
      have_title = dirname != SEEDS_PATH
      title = dirname.basename.to_s if have_title

      book = Book.find_by(title: title) if title
      book = create_book(title) if book.nil? || !book.persisted?

      cover = File.open(cover_path)
      book.covers.create(file: cover)
    end

    def create_book(title)
      title = FFaker::Book.title unless title
      FactoryGirl.create(:book, :with_authors, title: title)
    end
  end
end
