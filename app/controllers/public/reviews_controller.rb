class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!
  def index
    # 見直し
    @reviews = Review.all
    @rating = '評価'
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    # byebug
    @review = Review.new(review_params)
    @review.comment = params[:comment] # ストロングパラメタが治るといらない
    if @review.save
      redirect_to request.referer
    else
      redirect_to request.referer # エラ-文言を渡した方がいいかと.
    end
  end

  def review_params
    # 本来commentパラメタが取れるはず.
    params.require(:review).permit(:comment, :rating).merge(
      customer_id: current_customer.id, item_id: params[:item_id]
    )

  end
end

