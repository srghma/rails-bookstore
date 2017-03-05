module Settings
  class ProfileController < BaseController
    def show
      present SettingsPage::ProfilePresenter.new
    end

    def update
      SettingsPage::UpdateProfile.call(params, current_user) do
        on(:invalid) do |*attrs|
          present SettingsPage::ProfilePresenter.new(*attrs)
          render 'show'
        end
        on(:ok) do |type|
          redirect_to settings_profile_path,
                      flash: { success: "#{type.to_s.titleize} was successfully updated" }
        end
      end
    end

    def destroy
      current_user.destroy
      redirect_to root_path, flash: { warning: 'What you have done' }
    end
  end
end
