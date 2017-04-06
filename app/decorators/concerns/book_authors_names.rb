module BookAuthorsNames
  def authors_names
    __getobj__.authors.map(&:full_name).join(', ')
  end
end
