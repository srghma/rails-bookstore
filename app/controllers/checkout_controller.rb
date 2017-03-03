class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :fast_authenticate_user!
  before_action :set_progress_presenter

  steps :address, :delivery, :payment, :confirm, :complete

  rescue_from Wicked::Wizard::InvalidStepError do |_|
    redirect_to cart_path, alert: t('checkout.failure.invalid_step')
  end

  def show
    CheckoutPage::ValidateStep.call(current_order, step) do
      on(:cart_empty) do
        redirect_to cart_path, alert: t('checkout.failure.cart_empty')
      end
      on(:cant_access) do |minimal_accessible_step|
        redirect_to checkout_path(minimal_accessible_step),
                    flash: { error: t('checkout.failure.must_fill_previous') }
      end
      on(:ok) do
        present step_presenter.new
        render_wizard
      end
    end
  end

  def update
    CheckoutPage::ProceedCheckout.call(params, current_order, step) do
      on(:cant_access) do |minimal_accessible_step|
        redirect_to checkout_path(minimal_accessible_step),
                    flash: { error: t('checkout.failure.must_fill_previous') }
      end
      on(:invalid) do |*attrs|
        present step_presenter.new(*attrs)
        render_wizard
      end
      on(:ok) do |next_step|
        redirect_to checkout_path(next_step)
      end
      on(:finish) do |old_order|
        redirect_to finish_wizard_path(old_order)
      end
    end
  end

  private

  def finish_wizard_path(order)
    checkout_path(id: :complete, order_id: order.id)
  end

  def set_progress_presenter
    present CheckoutPage::ProgressPresenter.new, for: :progress
  end

  def step_presenter
    "CheckoutPage::#{step.capitalize}StepPresenter".constantize
  end
end
