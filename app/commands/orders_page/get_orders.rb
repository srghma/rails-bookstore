module OrdersPage
  class GetOrders < Rectify::Command
    FILTERS = [
      :all,
      :processing,
      :in_delivery,
      :delivered
    ].freeze

    def call
      set_current_filter
      broadcast(:invalid_filter) if @current_filter.nil?
      @current_filter ||= :all

      broadcast(:ok, orders, FILTERS, @current_filter)
    end

    def orders
      FilteredOrders.new(
        user: current_user,
        state: @current_filter
      ).query
    end

    private

    def set_current_filter
      filter = params[:filter]&.to_sym
      @current_filter = FILTERS.detect { |f| f == filter }
    end
  end
end
