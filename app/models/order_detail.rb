class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
    with_tax_price * amount
  end

  #製作ステータス(0=製作不可/1=製作待ち/2=製作中/3=製作完了)
  enum making_status: { impossible: 0, wait: 1, production: 2, completion: 3 }
end
