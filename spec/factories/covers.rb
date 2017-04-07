FactoryGirl.define do
  factory :cover do
    book
    file do
      image_path = Rails.root.join('spec', 'fixtures', 'assets', 'image_example.png')
      Rack::Test::UploadedFile.new(image_path)
    end
  end
end
