class ItemTag
  include ActiveModel::Model

  attr_accessor :id, :name, :product_description, :price, :image,
                :category_id, :status_id, :cover_delivery_cost_id,
                :prefecture_id, :delivery_id, :user_id,
                :tag_name

  validates :name, :product_description, :price, :image, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :category_id, :status_id, :cover_delivery_cost_id, :prefecture_id, :delivery_id, presence: true
  validates :status_id, :cover_delivery_cost_id, :prefecture_id, :delivery_id,
            numericality: { other_than: 1, message: 'を入力してください' }

  def save
    item = Item.create(
      name: name,
      product_description: product_description,
      price: price,
      image: image,
      category_id: category_id,
      status_id: status_id,
      cover_delivery_cost_id: cover_delivery_cost_id,
      prefecture_id: prefecture_id,
      delivery_id: delivery_id,
      user_id: user_id
    )

    return if tag_name.strip.blank?

    tag_name.split(',').each do |tag|
      cleaned_tag = tag.strip.downcase
      tag_record = Tag.find_or_create_by(tag_name: cleaned_tag)
      ItemTagRelation.create(item_id: item.id, tag_id: tag_record.id)
    end
  end

  def update
    item = Item.find(id)

    item.assign_attributes(
      name: name,
      product_description: product_description,
      price: price,
      category_id: category_id,
      status_id: status_id,
      cover_delivery_cost_id: cover_delivery_cost_id,
      prefecture_id: prefecture_id,
      delivery_id: delivery_id,
      user_id: user_id
    )

    # 🔽 新しい画像があれば上書き
    item.image.attach(image) if image.present?

    item.save

    # タグを一度削除して再登録
    item.item_tag_relations.destroy_all

    return if tag_name.blank?

    tag_name.split(',').each do |tag|
      cleaned_tag = tag.strip.downcase
      tag_record = Tag.find_or_create_by(tag_name: cleaned_tag)
      ItemTagRelation.create(item_id: item.id, tag_id: tag_record.id)
    end
  end
end
