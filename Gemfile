source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'haml-rails'
gem 'bootstrap-sass'

gem 'devise'
gem 'omniauth-facebook'
gem 'rails_admin'
gem 'rails_admin_dropzone'
gem 'cancancan'
gem 'aasm'
gem 'kaminari'

gem 'memoist'
gem 'yotpo'
gem 'rectify'
gem 'simple_form'
gem 'friendly_id'
gem 'wicked'
gem 'credit_card_validations'

gem 'carrierwave'
gem 'mini_magick'

gem 'rails-assets-tipsy', source: 'https://rails-assets.org'

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
  gem 'rails-controller-testing'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'capybara-screenshot'
  gem 'email_spec'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'database_cleaner'
  gem 'fuubar', require: false
  gem 'show_me_the_cookies'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
