feature 'Settings address page:' do
  populate_bookstore

  it 'dont pass guests' do
    visit settings_address_path
    expect(page).to have_current_path new_user_session_path
  end

  context 'when signed' do
    let!(:countries) { create_list :country, 10 }
    let!(:user) { create :user }
    let(:address) { attributes_for(:address) }

    before { sign_in user }
    before { visit settings_address_path }

    %i(billing shipping).each do |type|
      it "saves #{type} address" do
        within "form#edit_user_#{type}" do
          fill_address(:user, type, address, countries.sample)
          click_on 'Save'
        end
        expect(page).to have_current_path settings_address_path
        expect(page).to have_content 'successfully'

        reloaded = user.reload
        address = reloaded.send("#{type}_address")
        expect(address.first_name).to eq address.first_name
        expect(address.addressable).to eq reloaded
        opposite_type = %i(billing shipping).reject { |t| t == type }.first
        opposite = reloaded.send("#{opposite_type}_address")
        expect(opposite).to eq nil
      end

      it "saves #{type} address" do
        within "form#edit_user_#{type}" do
          fill_address(:user, type, address, countries.sample)
          fill_in "user[#{type}][zip]", with: 'asdf'
          click_on 'Save'
        end
        expect(page).to have_current_path settings_address_path
        expect(page).not_to have_content 'successfully'
        expect(page).to have_content 'is not a number'

        reloaded = user.reload
        address = reloaded.send("#{type}_address")
        expect(address).to eq nil
        opposite_type = %i(billing shipping).reject { |t| t == type }.first
        opposite = reloaded.send("#{opposite_type}_address")
        expect(opposite).to eq nil
      end
    end
  end

  context 'facebook signed' do
    let!(:countries) { create_list :country, 10 }
    let!(:user) { build :user }
    facebook_register_user

    before { visit settings_address_path }

    it 'show names from facebook account' do
      expect(find('#user_billing_first_name').value).to eq user.first_name
      expect(find('#user_billing_last_name').value).to eq user.last_name
      expect(find('#user_shipping_first_name').value).to eq user.first_name
      expect(find('#user_shipping_last_name').value).to eq user.last_name
    end
  end
end
