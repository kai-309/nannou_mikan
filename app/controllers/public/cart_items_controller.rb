class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    item = CartItem.find_by(item_id: params[:cart_item][:item_id], customer_id: current_customer.id)
    if item
      item.update(quantity: item.quantity.to_i + params[:cart_item][:quantity].to_i)
    else
      cart_item = CartItem.new(cart_item_params)
      cart_item.customer_id = current_customer.id
      cart_item.save
    end
    redirect_to cart_items_path
  end

  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal } #合計金額を算出
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end
end
