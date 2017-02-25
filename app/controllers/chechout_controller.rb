class ChechoutController < ApplicationController
  include Wicked::Wizard
  <`0`>
  steps :address, :delivery, :payment, :confirm
  
end
