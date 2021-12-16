class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    if @order_detail.making_ == "production"
      @order_detail.order.update(status: "production")
    end
    @order = @order_detail.order
    sum = 0
    @order.order_details.each do |order_detail|
      if order_detail.making_status == "completion"
        sum += 1
      end
    end
    if @order.order_details.count == sum
      @order_detail.order.update(status: "ready")
    end
    redirect_to request.referer
  end

  private
  #ストロングパラメーター
  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :making_status)
  end
end
