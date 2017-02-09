require 'factory_girl_rails'

Rake::Task['import_countries'].invoke

Book.delete_all

User.find_or_create_by(email: 'example@gmail.com') do |user|
  user.password = '123123123'
  user.is_admin = true
end

['Mobile development', 'Photo', 'Web design', 'Web development'].each do |title|
  Category.find_or_create_by(title: title)
end

Category.find_each do |category|
  3.times { FactoryGirl.create(:book_with_authors, category_id: category.id) }
end
