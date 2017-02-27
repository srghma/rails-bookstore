class ApplicationController < ActionController::Base
  include Rectify::ControllerHelpers
  include CurrentOrder

  before_action { present HeaderPresenter.new, for: :header }

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |_|
    redirect_to '/', alert: t('auth.access_denied')
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  def fast_authenticate_user!
    return if user_signed_in?
    session['user_return_to'] = request.fullpath
    redirect_to user_fast_path
  end
end
