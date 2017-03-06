FactoryGirl.define do
  factory :book do
    title            { FFaker::Book.title }
    description      { FFaker::Book.description }
    price            { FFaker.numerify('#.##') }
    in_stock         { rand(10) }
    height           { FFaker.numerify('#.#') }
    width            { FFaker.numerify('#.#') }
    depth            { FFaker.numerify('#.#') }
    publication_year { (1900 + rand(100)).to_s }
    materials        { FFaker::Lorem.words.join ', ' }
    category

    trait :with_authors do
      transient do
        number_of_authors :rand
      end

      after(:create) do |book, evaluator|
        number_of_authors = evaluator.number_of_authors == :rand ? rand(0..3) : evaluator.number_of_authors
        create_list :authorship, number_of_authors, book: book
      end
    end

    trait :with_orders do
      transient do
        number_of_orders 1
      end

      after(:create) do |book, evaluator|
        create_list :order_item, evaluator.number_of_orders, book: book
      end
    end

    trait :with_cover do
      transient do
        number_of_covers 1
      end

      after(:create) do |book, evaluator|
        create_list :cover, evaluator.number_of_covers, book: book
      end
    end
  end
end
