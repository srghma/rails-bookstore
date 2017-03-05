feature 'Book page:' do
  let!(:order) { create :order, :with_items }
  let(:item) { order.order_items.first }
  let(:book) { item.book }
  let(:update_size) { 3 }

  before { stub_current_order_with(order) }
  before { visit book_path(book) }

  it 'can add to cart' do
    expect(page).to have_current_path book_path(book)
    page.execute_script("$('#quantity').val(#{update_size})")
    click_button I18n.t('books.show.add_to_cart')

    expect(page).to have_current_path book_path(book)
    expect(item.reload.quantity).to eq update_size
  end
end
