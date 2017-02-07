class ApplicationController < ActionController::Base
  include CurrentOrder
  include YotpoWidgetHelper

  protect_from_forgery with: :exception

  before_action :set_categories
  attr_reader   :categories
  helper_method :categories

  rescue_from CanCan::AccessDenied do |_|
    redirect_to '/', alert: t('auth.access_denied')
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  def redirect_to_back_or_root(*args)
    if request.env['HTTP_REFERER'].present? &&
       request.env['HTTP_REFERER'] != request.env['REQUEST_URI']
      redirect_to :back, *args
    else
      redirect_to root_path, *args
    end
  end

  private

  def set_categories
    @categories ||= Category.all
  end
end
