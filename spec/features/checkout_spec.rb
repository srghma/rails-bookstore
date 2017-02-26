feature 'Checkout page:' do
  populate_bookstore

  before do
    login_as customer, scope: :customer
    visit cart_path
    click_link I18n.t('cart.checkout')
  end

  describe 'Address step' do
    let(:address) { attributes_for :address }
    before do
      within '.edit_order' do
        fill_in 'billing[address][first_name]', with: address[:first_name]
        fill_in 'billing[address][last_name]', with: address[:last_name]
        fill_in 'billing[address][address]', with: address[:address]
        fill_in 'billing[address][city]', with: address[:city]
        fill_in 'billing[address][zipcode]', with: address[:zipcode]
        fill_in 'billing[address][phone]', with: address[:phone]
      end
    end

    context 'when all fields valid' do
      it 'should show next step' do
        click_button 'Save & continue'
        expect(page).not_to have_content I18n.t('billing_address')
        expect(page).not_to have_content I18n.t('shipping_address')
      end
    end

    context 'when have invalid fields' do
      before do
        within '.edit_order' do
          fill_in 'billing[address][zipcode]', with: ''
        end
      end

      it 'should show errors' do
        click_button I18n.t('save_and_continue')
        expect(page).to have_content I18n.t('prohibited_from_save')
      end
    end
  end
end
