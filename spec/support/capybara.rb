Capybara.default_driver = :webkit
Capybara.javascript_driver = :webkit

# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, browser: :chrome)
# end
# Capybara.default_driver = :selenium
# Capybara.javascript_driver = :selenium

Capybara::Webkit.configure do |config|
  config.allow_url('www.gravatar.com')
  config.allow_url('jonathantweedy.com') # TODO: remove
  config.allow_url('w2.yotpo.com')
  config.allow_url('staticw2.yotpo.com')
  config.allow_url('fonts.googleapis.com')
end
