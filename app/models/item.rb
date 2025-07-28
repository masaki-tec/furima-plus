class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :cover_delivery_cost
  belongs_to :prefecture
  belongs_to :delivery

  belongs_to :user

  has_one_attached :image
  has_one :order

  validates :name, presence: true
  validates :product_description, presence: true
  validates :price, presence: true
  validates :image, presence: true

  validates :category_id, presence: { message: 'を入力してください' }
  validates :status_id, numericality: { other_than: 1, message: 'を入力してください' }
  validates :cover_delivery_cost_id, numericality: { other_than: 1, message: 'を入力してください' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'を入力してください' }
  validates :delivery_id, numericality: { other_than: 1, message: 'を入力してください' }

  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  def sold_out?
    order.present?
  end
end
