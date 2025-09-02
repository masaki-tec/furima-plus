require 'rails_helper'

RSpec.describe 'Item検索機能', type: :request do
  before do
    # Basic認証を通す
    user = ENV['BASIC_AUTH_USER'] || 'admin'
    password = ENV['BASIC_AUTH_PASSWORD'] || 'password'
    @auth_headers = {
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
    }

    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
    @item = FactoryBot.create(
      :item,
      user: @user,
      category: @category,
      name: '時計',
      product_description: '壁掛け時計'
    )
  end

  describe '検索バリデーション' do
    context 'キーワード検索' do
      it '20文字以内なら検索可能' do
        get items_path, params: { q: { name_or_product_description_or_tags_tag_name_or_user_nickname_cont: '時計' } },
                        headers: @auth_headers
        expect(response).to have_http_status(:success)
        expect(response.body).to include(@item.name)
      end

      it '20文字を超えるとflashエラー' do
        get items_path, params: { q: { name_or_product_description_or_tags_tag_name_or_user_nickname_cont: 'a' * 21 } },
                        headers: @auth_headers
        expect(response.body).to include('検索ワードは20文字以内で入力してください')
      end

      it '空文字でもエラーにならない' do
        get items_path, params: { q: { name_or_product_description_or_tags_tag_name_or_user_nickname_cont: '' } },
                        headers: @auth_headers
        expect(response).to have_http_status(:success)
      end
    end

    context 'カテゴリー検索' do
      it '整数なら検索可能' do
        get items_path, params: { q: { category_id_eq: @category.id } }, headers: @auth_headers
        expect(response).to have_http_status(:success)
        expect(response.body).to include(@item.name)
      end

      it '整数でないとflashエラー' do
        get items_path, params: { q: { category_id_eq: 'abc' } }, headers: @auth_headers
        expect(response.body).to include('カテゴリーが不正です')
      end

      it '空文字でもエラーにならない' do
        get items_path, params: { q: { category_id_eq: '' } }, headers: @auth_headers
        expect(response).to have_http_status(:success)
      end
    end
  end
end
