feature 'Checkout page:' do
  populate_bookstore
  before { sign_in create(:user) }

  context 'address' do
    let!(:countries) { create_list :country, 10 }

    before { visit checkout_path(:address) }

    describe 'Address step' do
      before do
        within '.edit_order' do
          fill_address(:billing,  attributes_for(:address), countries.first)
          fill_address(:shipping, attributes_for(:address), countries.second)
        end
      end

      context 'when all fields valid' do
        it 'should show next step' do
          click_button I18n.t('simple_form.titles.save_and_continue')
          expect(page.current_path).to eq checkout_path(:delivery)
          expect(ApplicationController.current_order.billing_address).to  be_present
          expect(ApplicationController.current_order.shipping_address).to be_present
        end
      end

      context 'when have invalid fields' do
        before do
          within '.edit_order' do
            fill_in 'order[billing][first_name]', with: ''
          end
        end

        it 'should show errors' do
          click_button I18n.t('simple_form.titles.save_and_continue')
          expect(page.current_path).to eq checkout_path(:address)
        end
      end
    end
  end
end
