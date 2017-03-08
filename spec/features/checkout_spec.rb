feature 'Checkout page:' do
  populate_bookstore
  let!(:user) { create(:user) }
  before { sign_in user }
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
          fill_address(:order, :billing,  attributes_for(:address), countries.first)
          fill_address(:order, :shipping, attributes_for(:address), countries.second)
        end
      end

      context 'when all fields valid' do
        it 'should show next step' do
          expect(Address.all.count).to eq 0
          click_button I18n.t('simple_form.titles.save_and_continue')
          expect(page).to have_current_path checkout_path(:delivery)
          expect(Address.all.count).to eq 2
        end
      end

      context 'when use_billing' do
        before do
          within '.edit_order' do
            click_checkbox
          end
        end
        it 'should show next step' do
          expect(Address.all.count).to eq 0
          click_button I18n.t('simple_form.titles.save_and_continue')

          expect(page).to have_current_path checkout_path(:delivery)
          expect(page.current_path).to eq checkout_path(:delivery)
          expect(Address.all.count).to eq 1
          expect(order.reload.use_billing).to eq true
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

    context 'when user have address in profile' do
      let!(:billing) { create :billing_address, addressable: user }
      let(:order) { create :order, :with_items }
      before { stub_current_order_with(order) }

      it 'show billing address from profile' do
        visit checkout_path(:address)
        fname = find('.edit_order').find('#order_billing_first_name').value
        expect(fname).to eq billing.first_name
      end
    end
  end

  describe 'Delivery' do
    let(:order) { create :order, :with_items, :with_addresses }
    before { stub_current_order_with(order) }

    before { visit checkout_path(:delivery) }

    it 'redirect to next page if click delivery' do
      expect(order.reload.delivery).to be_nil
      radios = all('.radio-icon')
      radios.first.click

      click_button I18n.t('simple_form.titles.save_and_continue')
      expect(page.current_path).to eq checkout_path(:payment)
      expect(order.reload.delivery).to be_present
    end

    it 'dont redirect to next page unless click delivery' do
      expect(order.reload.delivery).to be_nil

      click_button I18n.t('simple_form.titles.save_and_continue')
      expect(page.current_path).to eq checkout_path(:delivery)
      expect(order.reload.delivery).to be_nil
    end
  end

  describe 'Payment' do
    let(:order) { create :order, :with_items, :with_addresses, :with_delivery }
    before { stub_current_order_with(order) }
    before { visit checkout_path(:payment) }

    let(:card) { attributes_for :credit_card }

    before do
      within '.edit_order' do
        fill_card(card)
      end
    end

    it 'redirect to next page if valid' do
      expect(order.reload.credit_card).to be_nil
      click_button I18n.t('simple_form.titles.save_and_continue')

      expect(page.current_path).to eq checkout_path(:confirm)
      expect(order.reload.credit_card).to be_present
    end

    it 'dont redirect to next page unless valid' do
      within '.edit_order' do
        fill_in 'order[card][number]', with: ''
      end

      expect(order.reload.credit_card).to be_nil
      click_button I18n.t('simple_form.titles.save_and_continue')

      expect(page.current_path).to eq checkout_path(:payment)
      expect(order.reload.credit_card).to be_nil
    end
  end

  describe 'Confirm' do
    let(:order) { create :order, :with_items, :with_addresses, :with_delivery, :with_credit_card }
    before { stub_current_order_with(order) }

    context 'editing' do
      before do
        visit checkout_path(:confirm)
        expect(page.current_path).to eq checkout_path(:confirm)

        find_link('edit', match: :first).click
        expect(page.current_path).to eq checkout_path(:address)
      end

      it 'can edit billing address and jump back' do
        newname = 'Whatismyname'

        within '.edit_order' do
          fill_in 'order[billing][first_name]', with: newname
        end

        click_button I18n.t('simple_form.titles.save_and_continue')

        # if swap this two below - test will not pass, wha
        expect(page.current_path).to eq checkout_path(:confirm)
        expect(order.reload.billing_address.first_name).to eq newname
      end

      it 'will reload editing page is invalid' do
        within '.edit_order' do
          fill_in 'order[billing][first_name]', with: ''
        end

        click_button I18n.t('simple_form.titles.save_and_continue')
        expect(page.current_path).to eq checkout_path(:address)
      end
    end

    context 'when submitting' do
      before do
        visit checkout_path(:confirm)
        expect(page.current_path).to eq checkout_path(:confirm)
      end

      it 'should place order and render complete page only one time' do
        click_on I18n.t('simple_form.titles.place_order')

        # will wait for redirection
        expect(page).to have_current_path checkout_path(:complete)

        page.evaluate_script('window.location.reload()')
        expect(page).to have_current_path cart_path
        expect(order.reload.processing?).to eq true
        get_checkout_email(user.email)
        expect(page).to have_current_path order_path(order)
      end
    end
  end
end
