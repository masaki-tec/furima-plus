class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipality, :street_address, :building_name, :telephone_number, :user_id,
                :item_id, :token

  validates :post_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :municipality, presence: true
  validates :street_address, presence: true
  validates :telephone_number, presence: true
  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :token, presence: true

  def save
    @order = Order.create(user_id: user_id, item_id: item_id)

    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, street_address: street_address,
                   building_name: building_name, telephone_number: telephone_number, order_id: @order.id)
  end
end
