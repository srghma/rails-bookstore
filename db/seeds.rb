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
