class ApplicationController < ActionController::Base
  include CurrentOrder
  include AllCategories
  include YotpoHelper

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |_|
    redirect_to '/', alert: t('auth.access_denied')
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
