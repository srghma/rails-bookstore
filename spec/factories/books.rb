FactoryGirl.define do
  factory :book do
    title            { FFaker::Book.title }
    description      { FFaker::Book.description }
    price            { FFaker.numerify('#.##') }
    height           { FFaker.numerify('#.#') }
    width            { FFaker.numerify('#.#') }
    depth            { FFaker.numerify('#.#') }
    publication_year { FFaker::Time.date.year }
    materials        { FFaker::Lorem.words }
    category

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
