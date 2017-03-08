module OrderProductHelpers
  def create_or_increment_product(id, quantity = 1)
    item = order_items.find_or_initialize_by(book_id: id)
    item.quantity = item.persisted? ? item.quantity + quantity.to_i : quantity
    item.save ? item : false
  end

  def create_or_update_product(id, quantity = 1)
    item = order_items.find_or_initialize_by(book_id: id)
    item.quantity = quantity
    item.save ? item : false
  end
end
