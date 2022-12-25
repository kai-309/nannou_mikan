class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @review = Review.new
    @reviews = @item.reviews
    if params["latest"] == "true"
      @reviews = @item.reviews.latest
    elsif params["old"] == "true"
      @reviews = @item.reviews.old
    elsif params["rating"] == "true"
      @reviews = @item.reviews.rating
    else
      @reviews = @item.reviews.all
    end
    @item = Item.find(params[:id])
  end
end
