class PhoneNumberValidator < ActiveModel::EachValidator
  PHONE_NUMBER_REGEX = /\A[+?\d\ \-x\(\)]{7,}\z/

  def validate_each(record, attribute, value)
    return if value.match?(PHONE_NUMBER_REGEX)
    record.errors.add attribute, (options[:message] || 'is not a phone number')
  end
end
