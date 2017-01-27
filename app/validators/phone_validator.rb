class PhoneValidator < ActiveModel::EachValidator
  PHONE_REGEX = /\A[+?\d\ \-x\(\)]{7,}\z/

  # def initialize(options)
  #   puts "initialized"
  #   options.reverse_merge!(message: :bad_phone)
  #   super(options)
  # end

  def validate_each(record, attribute, value)
    return if value.match?(PHONE_REGEX)
    record.errors.add attribute, (options[:message] || 'is not a phone ')
  end
end
