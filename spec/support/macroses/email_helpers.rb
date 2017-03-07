module EmailHelpers
  def get_confirm_email(email)
    open_email(email)
    current_email.click_link 'Confirm my account'
  end
end

RSpec.configure do |config|
  config.include EmailHelpers, type: :feature
end
