class FilteredOrders
  def initialize(user:, state: nil)
    raise ArgumentError unless user
    @user = user
    @state = state
  end

  def query
    orders = @user.orders
    orders = orders.where(state: @state) if !@state.nil? && @state != :all
    orders
  end
end
