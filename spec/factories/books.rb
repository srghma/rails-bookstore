FactoryGirl.define do
  factory :book do
    title       { FFaker::Book.title }
    description { FFaker::Book.description }
    price       { FFaker::Commerce.price }
    category    { FFaker::Book.genre }
    author
  end
end
