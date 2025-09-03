require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:all) do
    I18n.locale = :ja
  end
  describe 'バリデーション' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
    end

    it 'テキストが存在すれば有効' do
      comment = FactoryBot.build(:comment, user: @user, item: @item, text: 'こんにちは')
      expect(comment).to be_valid
    end

    it 'テキストが空だと無効' do
      comment = FactoryBot.build(:comment, user: @user, item: @item, text: '')
      comment.valid?
      expect(comment.errors[:text]).to include('を入力してください')
    end

    it 'テキストが20文字以内なら有効' do
      comment = FactoryBot.build(:comment, user: @user, item: @item, text: 'a' * 20)
      expect(comment).to be_valid
    end

    it 'テキストが20文字を超えると無効' do
      comment = FactoryBot.build(:comment, user: @user, item: @item, text: 'a' * 21)
      comment.valid?
      expect(comment.errors[:text]).to include('は20文字以内で入力してください')
    end
  end
end
