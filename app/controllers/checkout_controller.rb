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
      on(:invalid, minimal_accessible_step) do
        redirect_to checkout_path(minimal_accessible_step),
                    flash: { error: t('.must_fill_previous') }
      end
      on(:ok) do
        present step_presenter.new
        render_wizard
      end
    end
  end

  def update
    CheckoutPage::ProceedCheckout.call(current_order, params, step) do
      on(:invalid)    { redirect_to cart_path }
      on(:validation) do
        present step_presenter.new
        render_wizard
      end
      on(:ok)         do
        present step_presenter.new
        render_wizard current_order
      end
    end
  end

  private

  def set_progress_presenter
    present CheckoutPage::ProgressPresenter.new, for: :progress
  end

  def step_presenter
    "CheckoutPage::#{step.capitalize}StepPresenter".constantize
  end
end
