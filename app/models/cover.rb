class Cover < Image
  belongs_to :book, foreign_key: 'source_id'

  mount CoverUploader, :file
end
