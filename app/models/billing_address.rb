class BillingAddress < Address
  self.inheritance_column = 'type'
end
