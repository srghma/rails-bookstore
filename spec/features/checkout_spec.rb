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
          expect(Address.all.count).to eq 0
          click_button I18n.t('simple_form.titles.save_and_continue')
          expect(page.current_path).to eq checkout_path(:delivery)
          expect(Address.all.count).to eq 2
        end
      end

      context 'when use_billing' do
        before do
          within '.edit_order' do
            find('.checkbox-icon').click # for selenium
            # find('.checkbox-icon').trigger('click') # for webkit
          end
        end
        it 'should show next step' do
          expect(Address.all.count).to eq 0
          click_button I18n.t('simple_form.titles.save_and_continue')

          expect(page).to have_current_path checkout_path(:delivery)
          expect(ShippingAddress.last.first_name).to eq BillingAddress.last.first_name
          expect(Address.all.count).to eq 2
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
  end

  describe 'Delively' do
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
        expect(page.current_path).to eq checkout_path(:complete)
        expect(order.reload.processing?).to eq true
        page.evaluate_script('window.location.reload()')
        require 'pry'; ::Kernel.binding.pry;
        expect(page.current_path).to eq cart_path
      end
    end
  end

  # describe 'Complete' do
  #   let(:order) do
  #     create :order,
  #            :with_items,
  #            :with_addresses,
  #            :with_delivery,
  #            :with_credit_card,
  #            state: :processing
  #   end
  #   before { stub_current_order_with(order) }

  #   it 'permit you to go to complete page' do
  #     visit checkout_path(:complete)
  #     expect(page).to have_current_path checkout_path(:complete)
  #   end

  #   it 'forbit you to go to other pages' do
  #     visit checkout_path(:address)
  #     expect(page).to have_current_path checkout_path(:complete)
  #   end

  #   it 'forbit you to go to complete page if current_order not ' do
  #     visit checkout_path(:address)
  #     expect(page).to have_current_path checkout_path(:complete)
  #   end
  # end
end
