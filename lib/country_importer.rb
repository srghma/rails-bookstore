module CountryImporter
  class << self
    def import
      path = Rails.root.join('db', 'country_seeds.txt')
      countries = File.readlines(path).map(&:strip).map { |c| c.split('|') }
      countries.each do |code, name|
        Shopper::Country.find_or_create_by(code: code, name: name)
      end
    end
  end
end
