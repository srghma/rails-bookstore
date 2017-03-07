feature 'Cart page:' do
  populate_bookstore
  let(:coupon) { create :coupon }
  let(:valid_code) { coupon.code }
  let(:invalid_code) { 'invalid' }

  context 'cart empty' do
    let(:order) { create(:order) }
    before { stub_current_order_with(order) }
    before { visit cart_path }

    it 'can add coupon' do
      fill_in 'coupon_code', with: valid_code
      click_button 'Update Cart'
      expect(page).to have_content 'Cart was updated successfully'
      expect(find('#coupon_code').value).to eq valid_code
      expect(order.reload.coupon.code).to eq valid_code
    end

    it 'dont attach if coupon invalid' do
      fill_in 'coupon_code', with: invalid_code
      click_button 'Update Cart'
      expect(page).to have_current_path cart_path
      expect(page).to have_content 'Invalid coupon code'
      expect(order.reload.coupon).to eq nil
    end
  end

  context 'cart with items and coupon' do
    let(:order) { create(:order, :with_items, coupon: coupon) }
    before { stub_current_order_with(order) }
    before { visit cart_path }

    it 'can deattach coupon' do
      fill_in 'coupon_code', with: ''
      click_on 'Update Cart'
      expect(page).to have_content 'Cart was updated successfully'
      expect(find('#coupon_code').value).to eq ''
      expect(order.reload.coupon).to eq nil
    end

    it 'can change items quantity' do
      new_quantity = 4
      page.execute_script("$('.quantity-input').first().val(#{new_quantity})")
      click_button 'Update Cart'
      expect(page).to have_content 'Cart was updated successfully'
      expect(order.reload.order_items.first.quantity).to eq new_quantity
    end

    it 'dont change items quantity if invalid' do
      target = order.order_items.first
      new_quantity = 0
      old_quantity = target.quantity
      page.execute_script("$('.quantity-input').first().val(#{new_quantity})")
      click_button 'Update Cart'
      expect(page).not_to have_content 'Cart was updated successfully'
      expect(target.reload.quantity).to eq old_quantity
    end

    it 'can remove items' do
      expect do
        first('.close').click
      end.to change { OrderItem.count }.by(-1)
    end
  end
end
