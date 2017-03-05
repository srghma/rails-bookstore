module SettingsPage
  class UpdateAddress < Rectify::Command
    def initialize(params, user)
      @params = params
      @user = user
    end

    def call
      set_type
      set_address

      return broadcast(:invalid, @type, @address) unless @address.valid?

      create_address
      broadcast(:ok, @type)
    end

    def set_type
      %i(billing shipping).each do |type|
        @type = type unless @params[:user][type].blank?
      end
    end

    def set_address
      params = @params.require(:user).require(@type).permit!.to_h
      @address = AddressForm.new(params)
    end

    def create_address
      @user.send("#{@type}_address")&.delete
      @user.send("create_#{@type}_address", @address.attributes)
    end
  end
end
