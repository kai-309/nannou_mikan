class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    cart_items = current_customer.cart_items.all
    # カート内が空の場合に注文画面へアクセスした時
    if cart_items.blank?
      redirect_to items_path
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @cart_items = current_customer.cart_items.all
    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = @order.order_details.new #注文詳細の作成
        @order_detail.item_id = cart_item.item_id #商品idの格納
        @order_detail.quantity = cart_item.quantity #商品の個数の格納
        @order_detail.inclusive_price = (cart_item.item.excluded_price * 1.10).floor #価格の格納
        @order_detail.save #注文詳細の保存。
      end
      @cart_items.destroy_all
      redirect_to complete_orders_path
    else
      render :new
    end
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
    @order.total_payment = @cart_items.inject(500) { |sum, item| sum + item.subtotal }
    @shipping_cost = 500
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def complete
    # ordersテーブル内の現在ログインしている会員の一番最後のレコードを取得する。
    @order = Order.where(customer_id: current_customer.id).last
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :total_payment, :shipping_cost, :status)
  end

  def address_params
    params.require(:order).permit(:attention_name, :address, :post_code)
  end

end
