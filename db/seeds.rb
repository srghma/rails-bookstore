Rake::Task['bookstore:import_countries'].invoke
Rake::Task['bookstore:import_books'].invoke

# create additional books without covers
Category.find_each do |category|
  FactoryGirl.create_list(:book, 3, :with_authors, category: category)
end

User.find_or_create_by(email: 'example@gmail.com') do |user|
  user.password = '123123123'
  user.is_admin = true
end

Delivery.create(title: 'Delivery next day', min_days: 3, max_days: 7, price: 5)
Delivery.create(title: 'Pick up In-Store',  min_days: 5, max_days: 20, price: 10)
Delivery.create(title: 'Expressit',         min_days: 2, max_days: 3, price: 15)

FactoryGirl.create_list(:coupon, 10)
