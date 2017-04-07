module Users
  class FastController < DeviseController
    before_action :create_customers
    prepend_before_action :allow_params_authentication!, only: :quick_session

    def show
      render 'devise/fast/show'
    end

    def quick_session
      user = warden.authenticate(auth_options)
      if user
        sign_in(resource_name, user)
        set_flash_message! :notice, :signed_in
        redirect_to after_sign_in_path_for(user)
      else
        @old_customer = resource_class.new(sign_in_params)
        flash[:error] = t('devise.failure.invalid', authentication_keys: 'email')
        render 'devise/fast/show'
      end
    end

    def quick_registration
      @new_customer = resource_class.from_fast_registration(sign_up_params)
      if @new_customer.persisted?
        set_flash_message! :notice, :signed_up
        sign_in(resource_name, @new_customer)
        url = after_sign_in_path_for(@new_customer)
        redirect_to url
      else
        render 'devise/fast/show'
      end
    end

    private

    def auth_options
      { scope: resource_name }
    end

    def create_customers
      @new_customer = @old_customer = resource_class.new
    end

    def sign_up_params
      devise_parameter_sanitizer.sanitize(:sign_up)
    end

    def sign_in_params
      devise_parameter_sanitizer.sanitize(:sign_in)
    end
  end
end
