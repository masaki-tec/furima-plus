class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :birth, presence: true

  encrypted_password = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates_format_of :password, with: encrypted_password, message: 'が無効です。英字と数字の両方を含めてください。'

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'が無効です。全角文字を入力してください。' } do
    validates :last_name, presence: true
    validates :first_name, presence: true
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'が無効です。全角文字(カタカナ)を入力してください。' } do
    validates :last_name_furigana, presence: true
    validates :first_name_furigana, presence: true
  end

  has_many :items
  has_many :orders
  has_many :comments
end
