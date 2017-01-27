class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEX = /\A\b[A-Z0-9\.\_\%\-\+]+@(?:[A-Z0-9\-]+\.)+[A-Z]{2,6}\b\z/i

  def validate_each(record, attribute, value)
    return if value.match?(EMAIL_REGEX)
    record.errors.add attribute, (options[:message] || 'is not an email')
  end
end
