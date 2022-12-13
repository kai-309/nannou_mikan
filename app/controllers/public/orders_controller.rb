class Public::OrdersController < ApplicationController
    before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @address = current_customer.addresses.all
  end
end
