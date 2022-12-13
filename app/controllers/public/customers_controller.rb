class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
   @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
   @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      redirect_to mypage_path
    else
      render "edit"
    end
  end

  def unsubscribe

  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number)
  end

end