class CheckoutMailer < ApplicationMailer
  def complete(user, order)
    @user = user
    @order = order
    mail to: @user.email, subject: "Order #{@order.number} completed"
  end
end
