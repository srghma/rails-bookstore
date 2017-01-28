class PhoneValidator < ActiveModel::EachValidator
  PHONE_REGEX = /\+\d{3}\ \d{2}\ \d{3}\ \d{4}/

  def validate_each(record, attribute, value)
    return if PHONE_REGEX.match? value
    message = options[:message] || :phone
    record.errors.add attribute, message
  end
end
