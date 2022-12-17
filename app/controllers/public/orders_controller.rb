class Public::OrdersController < ApplicationController
    before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @address = current_customer.addresses.all
  end


  def check
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    elsif params[:order][:address_number] == "2"
      if params[:order][:ship_id] == ""
        redirect_to new_order_path
      else
        ship = Address.find(params[:order][:ship_id])
        @order.post_code = ship.post_code
        @order.address = ship.address
        @order.name = ship.attention_name
      end
    elsif params[:order][:address_number] == "3"
      address_new = current_customer.addresses.new(address_params)
      address_new.save
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:attention_name]
      if params[:order][:post_code] == "" || params[:order][:address] == "" || params[:order][:name] == ""
        redirect_to new_order_path
      end
    else
      redirect_to new_order_path
    end
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_payment = @cart_items.inject(800) { |sum, item| sum + item.subtotal }
    @shipping_cost = 800
  end

end
