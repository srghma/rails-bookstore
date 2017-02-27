module Users
  class FastController < DeviseController
    before_action :create_customers
    prepend_before_action :allow_params_authentication!, only: :new_session

    def new
      render 'devise/fast/new'
    end

    def new_session
      user = warden.authenticate(auth_options)
      if user
        sign_in(resource_name, user)
        set_flash_message! :notice, :signed_in
        respond_with user, location: after_sign_in_path_for(user)
      else
        @old_customer = resource_class.new(sign_in_params)
        # TODO: still show has already been taken
        @old_customer.skip_email_uniqueness_validation = true
        @old_customer.valid?
        flash[:error] = t('devise.failure.invalid', authentication_keys: 'email')
        render 'devise/fast/new'
      end
    end

    def new_registration
      @new_customer = resource_class.new(sign_up_params)
      @new_customer.skip_password_validation = true
      if @new_customer.save
        set_flash_message! :notice, :signed_up
        sign_in(resource_name, @new_customer)
        respond_with @new_customer, location: after_sign_in_path_for(@new_customer)
      else
        render 'devise/fast/new'
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
