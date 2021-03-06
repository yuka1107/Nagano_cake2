class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def create
    address = Address.new(address_params)
    address.customer_id = current_customer.id
    if address.save
      redirect_to addresses_path
    end
  end

  def index
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    @address = Address.find(params[:id])
    if @address.destroy
    redirect_to addresses_path
    end
  end

  private
  #ストロングパラメーター
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end

end
