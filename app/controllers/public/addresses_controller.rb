class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end


  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path
  end

   private

  def address_params
    params.require(:address).permit(:post_code,:address,:attention_name)
  end
end