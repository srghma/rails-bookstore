Capybara.default_driver = :webkit
Capybara.javascript_driver = :webkit

# TODO: remove
Capybara::Webkit.configure do |config|
  config.allow_url('jonathantweedy.com')
end
