Capybara.default_driver = :webkit
Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.allow_url('www.gravatar.com')
  config.allow_url('jonathantweedy.com') # TODO: remove
  config.allow_url('w2.yotpo.com')
  config.allow_url('staticw2.yotpo.com')
  config.allow_url('fonts.googleapis.com')
end
