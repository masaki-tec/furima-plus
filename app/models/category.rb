class Category < ApplicationRecord
  has_ancestry

  has_many :items

  # 孫カテゴリかどうか判定
  def grandchild?
    parent.present? && children.empty?
  end
end
