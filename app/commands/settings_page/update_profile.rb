module SettingsPage
  class UpdateProfile < Rectify::Command
    def initialize(params, user)
      @params = params
      @user = user
    end

    def call
      set_type

      case @type
      when :email
        result = @user.update_without_password params_for(:email)
        return broadcast(:invalid, @type, @user) unless result
        broadcast(:ok, @type)
      when :password
        result = @user.update_with_password params_for(:password)
        return broadcast(:invalid, @type, @user) unless result
        bypass_sign_in(@user)
        broadcast(:ok, @type)
      end
    end

    def set_type
      %i(email password).each do |type|
        @type = type unless @params[:user]["#{type}_form"].blank?
      end
    end

    def params_for(type)
      @params.require(:user).require("#{type}_form").permit!.to_h
    end
  end
end
