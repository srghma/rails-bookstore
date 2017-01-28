class PhoneValidator < ActiveModel::EachValidator
  PHONE_REGEX = /\A[+?\d\ \-x\(\)]{7,}\z/

  def validate_each(record, attribute, value)
    return if value.match?(PHONE_REGEX)
    message = options[:message] || :bad_phone
    record.errors.add attribute, message
  end
end
