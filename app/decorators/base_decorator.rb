class BaseDecorator < SimpleDelegator
  def urls
    Rails.application.routes.url_helpers
  end

  def helpers
    ActionController::Base.helpers
  end
end
