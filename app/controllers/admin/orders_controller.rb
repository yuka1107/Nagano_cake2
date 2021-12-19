class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
    redirect_to admin_order_path(@order)
    end
  end

  private
  #ストロングパラメーター
  def order_params
    params.require(:order).permit(:status)
  end
end
