module BookAuthorsNames
  extend ActiveSupport::Concern

  included do
    def authors_names
      __getobj__.authors.map(&:full_name).join(', ')
    end
  end
end
