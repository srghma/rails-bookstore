module SettingsPage
  class AddressesPresenter < Rectify::Presenter
    def initialize(invalid_address_type = nil, invalid_address_form = nil)
      @invalid_address_type = invalid_address_type
      @invalid_address_form = invalid_address_form
      super()
    end

    def billing
      @billing ||= address(:billing)
    end

    def shipping
      @shipping ||= address(:shipping)
    end

    def selected_country_id(type)
      send(type).country_id || 1
    end

    def countries
      Shopper::Country.order(:name).pluck(:name, :id)
    end

    private

    def address(type)
      return @invalid_address_form if @invalid_address_type == type

      user_address = current_user.send("#{type}_address")
      return user_address if user_address

      "Shopper::#{type.capitalize}Address".constantize.new(
        first_name: current_user.first_name,
        last_name:  current_user.last_name
      )
    end
  end
end
