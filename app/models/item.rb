class Item < ApplicationRecord

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_detail, dependent: :destroy

  attachment :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :image, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true
  validates :is_active, presence: true

  def with_tax_price
    (price * 1.1).floor
  end
end
