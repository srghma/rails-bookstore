class CheckoutMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)

  def complete(user, order)
    @user = user
    @order = order
    mail to: @user.email, subject: "Order #{@order.number} completed"
  end
end
