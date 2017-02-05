Dir[Rails.root.join('app', 'uploaders', '*.rb')].each { |file| require file }

CarrierWave::Uploader::Base.descendants.each do |klass|
  next if klass.anonymous?
  klass.class_eval do
    def store_dir
      "test_uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def cache_dir
      'test_uploads/tmp'
    end
  end
end

RSpec.configure do |config|
  config.after(:all) do
    FileUtils.rm_rf(Rails.root.join('public', 'test_uploads'))
  end
end
