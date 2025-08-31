require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    I18n.locale = :ja # ← ここでテスト時に日本語化
    @tag = FactoryBot.build(:tag)
  end

  describe 'タグ登録' do
    context '登録できる場合' do
      it '有効なタグ名であれば登録できる' do
        expect(@tag).to be_valid
      end

      it 'タグ名が20文字以内なら登録できる' do
        @tag.tag_name = 'a' * 20
        expect(@tag).to be_valid
      end
    end

    context '登録できない場合' do
      it '同じタグ名（大文字小文字違い含む）は登録できない' do
        @tag.tag_name = 'Ruby'
        @tag.save
        another_tag = FactoryBot.build(:tag, tag_name: 'ruby')
        another_tag.valid? # ← これで errors が生成される
        expect(another_tag.errors[:tag_name]).to include('はすでに存在します')
      end

      it 'タグ名が21文字以上だと登録できない' do
        @tag.tag_name = 'a' * 21
        @tag.valid?
        expect(@tag.errors[:tag_name]).to include('は20文字以内で入力してください')
      end
    end
  end
end
