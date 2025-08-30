require 'rails_helper'

RSpec.describe ItemTag, type: :model do
  before do
    @item_tag = FactoryBot.build(:item_tag)
  end

  describe '商品出品（ItemTag）' do
    context '商品出品できる場合' do
      it '全ての項目が正しく入力されていれば有効' do
        expect(@item_tag).to be_valid
      end
    end

    context '商品出品できない場合' do
      it 'nameが空では登録できない' do
        @item_tag.name = ''
        expect(@item_tag).not_to be_valid
      end

      it 'product_descriptionが空では登録できない' do
        @item_tag.product_description = ''
        expect(@item_tag).not_to be_valid
      end

      it 'priceが空では登録できない' do
        @item_tag.price = nil
        expect(@item_tag).not_to be_valid
      end

      it 'priceが299以下だと登録できない' do
        @item_tag.price = 299
        expect(@item_tag).not_to be_valid
      end

      it 'priceが10_000_000以上だと登録できない' do
        @item_tag.price = 10_000_000
        expect(@item_tag).not_to be_valid
      end

      it 'imageがないと登録できない' do
        @item_tag.image = nil
        expect(@item_tag).not_to be_valid
      end

      it 'category_idが空では登録できない' do
        @item_tag.category_id = nil
        expect(@item_tag).not_to be_valid
      end

      it 'status_idが1では登録できない' do
        @item_tag.status_id = 1
        expect(@item_tag).not_to be_valid
      end

      it 'cover_delivery_cost_idが1では登録できない' do
        @item_tag.cover_delivery_cost_id = 1
        expect(@item_tag).not_to be_valid
      end

      it 'prefecture_idが1では登録できない' do
        @item_tag.prefecture_id = 1
        expect(@item_tag).not_to be_valid
      end

      it 'delivery_idが1では登録できない' do
        @item_tag.delivery_id = 1
        expect(@item_tag).not_to be_valid
      end
    end
  end
end
