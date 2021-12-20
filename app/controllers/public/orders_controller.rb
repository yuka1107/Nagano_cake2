class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = CartItem.all
    @order.shipping_cost = 800
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
    end
  end

  def create
    @order = Order.new(order_params)
    @order.shipping_cost = 800
    @order.status = 0
    @order.customer_id = current_customer.id
    @order.payment_method = current_customer.cart_total + @order.shipping_cost
    @order.save
    current_customer.cart_items.all.each do |cart_item|
      OrderDetail.create!(item_id: cart_item.item_id, amount: cart_item.amount, price: cart_item.subtotal, order_id: @order.id)
    end
    current_customer.cart_items.destroy_all
    redirect_to thanks_orders_path
  end

  def thanks
  end

  def index
    @order_details = OrderDetail.all
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order.shipping_cost = 800
    @order_details = @order.order_details
    @total = @order.total_payment - @order.shipping_cost
  end

  private
  #ストロングパラメーター
  def order_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address, :shipping_cost, :total_payment, :payment_method)
  end
end
