feature 'Admin page:' do
  context 'when ordinary user' do
    before { sign_in create(:user) }

    scenario 'cannot visit' do
      visit rails_admin_path
      expect(current_path).to eq root_path
    end
  end

  # TODO: poltergeist error https://github.com/sferik/rails_admin/issues/2838
  # context 'when admin' do
  #   before { sign_in create(:admin) }

  #   scenario 'can visit' do
  #     visit rails_admin_path
  #     expect(current_path).to eq rails_admin_path
  #   end
  # end
end
