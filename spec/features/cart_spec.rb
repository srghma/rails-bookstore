feature 'Cart page:' do
  populate_bookstore
  let(:coupon) { create :coupon }
  let(:valid_code) { coupon.code }
  let(:invalid_code) { 'invalid' }

  context 'coupon not exitsts' do
    before { visit cart_path }

    scenario 'can add coupon' do
      fill_in 'coupon_code', with: valid_code
      click_button 'Update Cart'
      expect(page).to have_content 'Cart was updated successfully'
      expect(find('#coupon_code').value).to eq valid_code
    end
  end

  context 'coupon exists' do
    let(:order) { create(:order, :with_items, coupon: coupon) }
    before do
      stub_current_order_with(order)
      visit cart_path
    end

    if Capybara.default_driver == :selenium_chrome
      scenario 'can deattach coupon' do
        fill_in 'coupon_code', with: ''
        click_on 'Update Cart'
        # because of overlapping footer
        # sometimes this work on webkit
        # page.execute_script %($('form').first().submit())
        expect(page).to have_content 'Cart was updated successfully'
        expect(find('#coupon_code').value).to eq ''
      end
    end
  end
end
