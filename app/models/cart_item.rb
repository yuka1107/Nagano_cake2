class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :item, presence: true
end
