class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @reviews = Review.all
    @rating = '評価'
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to request.referer
    else
    end
  end

  def review_params
    params.require(:review).permit(:comment, :rating).merge(
      customer_id: current_customer.id, item_id: params[:item_id]
    )
  end
end

