module OrderItemArithmeticHelpers
  def subtotal
    quantity * book.price
  end
end
