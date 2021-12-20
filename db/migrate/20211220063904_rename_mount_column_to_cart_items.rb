class RenameMountColumnToCartItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :cart_items, :mount, :amount
  end
end
