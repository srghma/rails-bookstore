module BookImporter
  SEEDS_PATH = Rails.root.join('db', 'book_seeds')

  CATEGORY_TITLES = [
    'Mobile development',
    'Photo',
    'Web design',
    'Web development'
  ].freeze

  class << self
    def import
      import_directory(SEEDS_PATH)
    end

    def import_directory(path)
      Dir.chdir(path) do
        Dir.glob('*').each do |entry|
          entry = path.join(entry)
          File.directory?(entry) ? import_directory(entry) : create_cover(entry)
        end
      end
    end

    def create_cover(cover_path)
      dirname = cover_path.dirname
      have_title = dirname != SEEDS_PATH
      title = have_title ? dirname.basename.to_s : nil

      book = find_or_create_book(title)

      cover = File.open(cover_path)
      book.covers.create(file: cover)
    end

    def find_or_create_book(title)
      book = Book.find_by(title: title)
      return book if book
      title ||= FFaker::Book.title
      FactoryGirl.create(:book, :with_authors, title: title, category: category_sample)
    end

    def category_sample
      Category.find_or_create_by(title: CATEGORY_TITLES.sample)
    end
  end
end
