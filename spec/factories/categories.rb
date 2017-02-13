# TODO: find better place for TITLES, non global? (using it in tasks_spac)
TITLES = [
  'Mobile development',
  'Photo',
  'Web design',
  'Web development'
].freeze

FactoryGirl.define do
  factory :category do
    title { TITLES.sample }

    # because categories should be unique by titles
    initialize_with { Category.find_or_create_by(title: title) }
  end
end
