module CountryImporter
  class << self
    def import
      file = Rails.root.join('db', 'country_seeds.txt')
      countries = File.readlines(file)
    end
  end
end
