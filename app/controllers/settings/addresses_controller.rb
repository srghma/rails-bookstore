module Settings
  class AddressesController < BaseController
    def show
      present SettingsPage::AddressesPresenter.new
    end

    def update
      SettingsPage::UpdateAddress.call(params, current_user) do
        on(:invalid) do |*attrs|
          present SettingsPage::AddressesPresenter.new(*attrs)
          render 'show'
        end
        on(:ok) do |type|
          redirect_to settings_address_path,
                      flash: { success: "#{type.to_s.titleize} address was successfully updated" }
        end
      end
    end
  end
end
