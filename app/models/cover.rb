class Cover < ApplicationRecord
  belongs_to :book

  mount_uploader :file, CoverUploader

  validates :book, presence: true
  validates :file, presence: true

  def to_s
    file_identifier
  end
end
