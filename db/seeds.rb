# Rake::Task['bookstore:import_countries'].invoke
# Rake::Task['bookstore:import_books'].invoke

raise 'Category table is empty, run bookstore:import_books to populate categories first'\
  if Category.all.empty?

# create additional books without covers
Category.find_each do |category|
  FactoryGirl.create_list(:book, 3, :with_authors, category: category)
end

Shopper::Delivery.create(title: 'Delivery next day', min_days: 3, max_days: 7, price: 5)
Shopper::Delivery.create(title: 'Pick up In-Store',  min_days: 5, max_days: 20, price: 10)
Shopper::Delivery.create(title: 'Expressit',         min_days: 2, max_days: 3, price: 15)

FactoryGirl.create_list(:coupon, 10)

User.find_or_create_by(email: 'example@gmail.com') do |user|
  user.password = '123123123'
  user.is_admin = true
  user.confirmed_at = Time.zone.now
end
