RSpec.describe 'ユーザー管理と商品購入', type: :system do
  before do
    driven_by(:rack_test) # JSを含む場合は :selenium_chrome_headless
  end

  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:item, user: user) }