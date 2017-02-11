require 'factory_girl_rails'

Rake::Task['bookstore:import_countries'].invoke

Rake::Task['bookstore:import_books'].invoke

User.find_or_create_by(email: 'example@gmail.com') do |user|
  user.password = '123123123'
  user.is_admin = true
end
