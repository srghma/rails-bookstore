class ShippingAddress < Address
  self.inheritance_column = 'type'
end
