Rake::Task['bookstore:import_countries'].invoke
Rake::Task['bookstore:import_books'].invoke

# additional books without covers
FactoryGirl.create_list(:book, 10, :with_authors)

User.find_or_create_by(email: 'example@gmail.com') do |user|
  user.password = '123123123'
  user.is_admin = true
end
