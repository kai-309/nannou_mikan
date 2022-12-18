class Admin::CustomersController < ApplicationController
    before_action :authenticate_admin!

  def index
    @customers = Customer.all
    @customer = Customer.page(params[:page]).per(10)
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_kana, :first_kana, :post_code, :address, :tell, :email, :is_deleted)
  end
end
