class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @address = current_customer.addresses.new(address_params)
    @address.save
    redirect_to addresses_path
  end

  def index
    @address = Address.new
    @addresses = current_customer.addresses
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
    @address.destroy
    redirect_to addresses_path
  end

  private
  #ストロングパラメーター
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end

end
