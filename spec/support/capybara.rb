Capybara.default_driver = :webkit
Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.allow_url('www.gravatar.com')
  config.allow_url('www.jonathantweedy.com')
end
