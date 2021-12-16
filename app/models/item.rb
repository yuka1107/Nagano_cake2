class Item < ApplicationRecord

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_detail, dependent: :destroy

  attachment :image

  def with_tax_price
    price * 1.1
  end

end
