module SettingsPage
  class UpdateProfile < Rectify::Command
    def initialize(params, user)
      @params = params
      @user = user
    end

    def call
      @email_params = params_for_email
      @password_params = params_for_password

      if @email_params then update_email
      elsif @password_params then update_password
      else broadcast(:invalid)
      end
    end

    def update_email
      if @user.update_without_password @email_params
        broadcast(:ok, @type)
      else
        broadcast(:validate, @type, @user)
      end
    end

    def update_password
      result = if @user.provider
                 @user.update_attributes(password: @password_params[:password])
               else
                 @user.update_with_password @password_params
               end
      return broadcast(:validate, @type, @user) unless result
      bypass_sign_in(@user)
      broadcast(:ok, @type)
    end

    def params_for_email
      @params.require(:user).require(:email_form).permit(:email)
    rescue ActionController::ParameterMissing
      nil
    end

    def params_for_password
      @params.require(:user)
             .require(:password_form)
             .permit(:current_password, :password, :password_confirmation)
    rescue ActionController::ParameterMissing
      nil
    end
  end
end
