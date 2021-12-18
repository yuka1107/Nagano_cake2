class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
     @cart_item = CartItem.new
    @cart_item.customer_id = current_customer.id
    @cart_item_find = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item_find
      @cart_item_find.update(amount: @cart_item_find.amount + (params[:cart_item][:amount].to_i))
    else
      @cart_item.save
    end
    redirect_to cart_items_path
  end

  def index
   @cart_items = current_customer.cart_items
    @total = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end

  private
  #ストロングパラメーター
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end
