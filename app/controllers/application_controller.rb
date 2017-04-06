class ApplicationController < ActionController::Base
  include Rectify::ControllerHelpers
  include Shopper::CurrentOrder
  include FastAuth

  before_action { present HeaderPresenter.new, for: :header }

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |_|
    redirect_to '/', alert: t('auth.access_denied')
  end

  alias current_customer current_user
  helper_method :current_customer

  private

  def current_ability
    @current_ability ||= Ability.new(current_user, current_order)
  end
end
