class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  #顧客のマイページ
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
    redirect_to customers_path
    else
      render :edit
    end
  end

  #顧客の退会確認
  def unsubscribe
    @customer = current_customer
  end

  #顧客の退会処理
  def withdraw
    @customer = current_customer
    if @customer.update(is_active: false)
      reset_session
      redirect_to root_path
    end  
  end

  private
  #ストロングパラメーター
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end

end
