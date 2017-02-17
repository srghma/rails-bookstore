class ApplicationController < ActionController::Base
  include Rectify::ControllerHelpers
  include CurrentOrder
  include YotpoHelper

  before_action { present HeaderPresenter.new, for: :header }

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |_|
    redirect_to '/', alert: t('auth.access_denied')
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
