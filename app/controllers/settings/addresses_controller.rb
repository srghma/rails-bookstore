module Settings
  class AddressesController < BaseController
    def show
      present SettingsPage::AddressesPresenter
    end

    def update

    end
  end
end
