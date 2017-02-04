FactoryGirl.define do
  factory :book do
    title       { FFaker::Book.title }
    description { FFaker::Book.description }
    price       { FFaker.numerify('#.##') }
    category

    factory :book_with_authors do
      transient do
        authorships_count 1
      end

      after(:create) do |book, evaluator|
        evaluator.authorships_count.times do
          book.authorships << create(:authorship, book: book)
        end
      end
    end
  end
end
