class BaseDecorator < SimpleDelegator
  def self.for_collection(objects)
    objects.map { |object| new(object) }
  end

  def urls
    Rails.application.routes.url_helpers
  end

  def helpers
    ActionController::Base.helpers
  end
end
