class Tag < ApplicationRecord
  has_many :item_tag_relations
  has_many :items, through: :item_tag_relations
  validates :tag_name, uniqueness: { case_sensitive: false }, length: { maximum: 20 }

  # Ransackで検索可能な属性を明示
  def self.ransackable_attributes(auth_object = nil)
    %w[id tag_name created_at updated_at]
  end
end
