class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_detail, dependent: :destroy

  #支払方法ステータス(0=クレジットカード/1=銀行振込)
  enum payment_method: { credit_card: 0, transfer: 1 }
  #受注ステータス(0=入金待ち/1=入金確認/2=製作中/3=発送準備中/4=発送済み)
  enum status: { wait: 0, confirm: 1, production: 2, ready: 3, sent: 4 }

end
