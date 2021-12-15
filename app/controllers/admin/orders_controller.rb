class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == "confirm"
      @order.order_details.update(making: "wait")
    end
    redirect_to admin_order_path(@order.id)
  end

  private
  #ストロングパラメーター
  def order_params
    params.require(:oder).permit(:status)
  end
end
