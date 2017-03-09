class CheckoutController < ApplicationController
  include CheckoutWizard

  before_action :fast_authenticate_user!
  before_action :check_empty_cart
  before_action :check_accesability, except: :complete

  before_action :set_progress_presenter

  rescue_from Wicked::Wizard::InvalidStepError do |_|
    redirect_to cart_path, alert: t('checkout.failure.invalid_step')
  end

  rescue_from CheckoutWizard::EmptyCardError do |_|
    redirect_to cart_path, alert: t('checkout.failure.cart_empty')
  end

  rescue_from CheckoutWizard::CantAccessError do |_|
    redirect_to checkout_path(minimal_accessible_step),
                flash: { error: t('checkout.failure.must_fill_previous') }
  end

  def show
    present step_presenter.new
    render_wizard
  end

  def update
    CheckoutPage::ProceedCheckout.call(params, current_order, step) do
      on(:invalid) do |*attrs|
        present step_presenter.new(*attrs)
        render_wizard
      end
      on(:ok) { redirect_to_next_step }
    end
  end

  def complete
    CheckoutPage::PlaceOrder.call(params, current_order) do
      on(:invalid) { redirect_to cart_path, alert: t('checkout.failure.invalid_step') }
      on(:ok) do |old_order|
        present step_presenter.new(old_order)
        render_wizard
      end
    end
  end

  private

  def set_progress_presenter
    select_up_to_step = minimal_accessible_step
    select_up_to_step = :complete if step == :complete
    present CheckoutPage::ProgressPresenter.new(
      steps,
      step,
      select_up_to_step
    ), for: :progress
  end

  def step_presenter
    "CheckoutPage::#{step.capitalize}StepPresenter".constantize
  end
end
