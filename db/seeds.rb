require 'factory_girl_rails'

Book.delete_all

User.find_or_create_by(email: 'example@gmail.com') do |user|
  user.password = '123123123'
end

Admin.find_or_create_by(email: 'example@gmail.com') do |admin|
  admin.password = '123123123'
end

['Mobile development', 'Photo', 'Web design', 'Web development'].each do |title|
  Category.find_or_create_by(title: title)
end

Category.find_each do |category|
  3.times { FactoryGirl.create(:book_with_authors, category_id: category.id) }
end
