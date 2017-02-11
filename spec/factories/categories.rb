FactoryGirl.define do
  factory :category do
    titles = [
      'Mobile development',
      'Photo',
      'Web design',
      'Web development'
    ]
    title { titles.sample }
  end
end
