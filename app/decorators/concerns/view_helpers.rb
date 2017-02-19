module ViewHelpers
  extend ActiveSupport::Concern

  included do
    def urls
      Rails.application.routes.url_helpers
    end

    def helpers
      ActionController::Base.helpers
    end
  end
end
