class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    redirect_to :show
  end

  private
  #ストロングパラメーター
  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :making_status)
  end
end
