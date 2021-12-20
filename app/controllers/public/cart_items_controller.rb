class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    #もしカート内同一商品が存在していたら
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.save
      redirect_to cart_items_path
    #なかったら
    else
      @cart_item.save
      redirect_to cart_items_path
    end

  end

  def index
   @cart_items = current_customer.cart_items
   @total = 0
  end

  #カート内個数変更
  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
    redirect_to cart_items_path
    else
      render :index
    end
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
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
