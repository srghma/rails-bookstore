namespace :bookstore do
  desc 'Import default set of countries'
  task import_countries: :environment do
    CountryImporter.import
  end

  desc 'Import default set of books with covers'
  task import_books: :environment do
    BookImporter.import
  end
end
