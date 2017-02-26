class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :address, :delivery, :payment, :confirm, :complete
  before_action :set_progress_presenter

  def show
    CheckoutPage::ValidateStep.call(step) do
      on(:invalid) { redirect_to cart_path, error: t('.invalid') }
      on(:ok) do
        present step_presenter.new
        render_wizard
      end
    end
  end

  def update
    CheckoutPage::ProceedCheckout.call(step, params) do
      on(:invalid)    { redirect_to cart_path }
      on(:validation) { render_wizard }
      on(:ok)         do
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
