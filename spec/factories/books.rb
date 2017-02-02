FactoryGirl.define do
  factory :book do
    title       { FFaker::Book.title }
    description { FFaker::Book.description }
    price       { FFaker.numerify("#.##") }
    category    { FFaker::Book.genre }

    factory :book_with_authors do
      transient do
        authorships_count 1
      end

      after(:create) do |book, evaluator|
        evaluator.authorships_count.times do
          book.authorships << create(:authorship, book: book)
        end
        # create_list(:authorhip, evaluator.authorships_count, book: book)
      end
    end
  end
end
