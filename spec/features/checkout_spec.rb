feature 'Checkout page:' do
  populate_bookstore
  before { sign_in create(:user) }
  before { create_list :delivery, 3 }

  describe 'Address step' do
    let!(:countries) { create_list :country, 10 }

    context 'without order items' do
      it 'should not allow to checkout page' do
        visit checkout_path(:address)
        expect(page.current_path).to eq cart_path
      end
    end

    context 'with order items' do
      let(:order) { create :order, :with_items }
      before { stub_current_order_with(order) }
      before { visit checkout_path(:address) }

      before do
        within '.edit_order' do
          fill_address(:billing,  attributes_for(:address), countries.first)
          fill_address(:shipping, attributes_for(:address), countries.second)
        end
      end

      context 'when all fields valid' do
        it 'should show next step' do
          expect {
            click_button I18n.t('simple_form.titles.save_and_continue')
          }.to change {
            Address.all.count
          }.by(2)

          expect(page.current_path).to eq checkout_path(:delivery)
        end
      end

      context 'when use_billing' do
        before do
          within '.edit_order' do
            find(:css, '.checkbox-icon').click
          end
        end
        it 'should show next step' do
          expect {
            click_button I18n.t('simple_form.titles.save_and_continue')
          }.to change {
            Address.all.count
          }.by(2)

          expect(ShippingAddress.last.first_name).to eq BillingAddress.last.first_name
          expect(page.current_path).to eq checkout_path(:delivery)
        end
      end

      context 'when have invalid fields' do
        before do
          within '.edit_order' do
            fill_in 'order[billing][first_name]', with: ''
          end
        end

        it 'should show errors' do
          expect {
            click_button I18n.t('simple_form.titles.save_and_continue')
          }.not_to change {
            Address.count
          }
          expect(page.current_path).to eq checkout_path(:address)
          expect(page).to have_content 'can\'t be blank'
        end
      end
    end

    describe 'Delively' do
      context 'delivery' do
        before { visit checkout_path(:delivery) }
        let(:order) { create :order, :with_items, :with_addresses }
        before do
          stub_current_order_with(order)
        end
      end
    end
  end
end
