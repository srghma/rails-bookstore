source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'haml-rails'
gem 'bootstrap-sass'

gem 'country_select'
gem 'devise'
gem 'omniauth-facebook'
gem 'rails_admin'
gem 'cancancan'
gem 'aasm'
gem 'kaminari'

# File uploader
gem 'carrierwave'
gem 'mini_magick'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'awesome_pry'
  gem 'guard-livereload', require: false
  gem 'guard-rspec', require: false
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'sqlite3'
  gem 'dotenv-rails'

  # RSpec
  gem 'rspec-rails'
  gem 'capybara-webkit'
  gem 'email_spec'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'database_cleaner'
  gem 'fuubar', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
