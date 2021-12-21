class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  #会員一覧
  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

　#会員詳細
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path
  end

  private
  #ストロングパラメーター
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_active)
  end
end
