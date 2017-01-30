ActiveSupport.on_load :action_controller do
  ActionController::Base.include CurrentOrder
end
