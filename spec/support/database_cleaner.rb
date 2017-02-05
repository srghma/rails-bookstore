RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation, { pre_count: true, reset_ids: true }
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
