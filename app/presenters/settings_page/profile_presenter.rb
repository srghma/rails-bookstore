module SettingsPage
  class ProfilePresenter < Rectify::Presenter
    def initialize(type = nil, form = nil)
      instance_variable_set("@#{type}_form", form)
    end

    def email_form
      @email_form || current_user
    end

    def password_form
      @password_form || current_user
    end
  end
end
