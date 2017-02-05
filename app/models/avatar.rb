class Avatar < Image
  belongs_to :user, foreign_key: 'source_id'

  mount AvatarUploader, :file
end
