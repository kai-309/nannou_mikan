class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @item = Item.new
  end

  def create

    @item = Item.new(item_params)
    @item.admin_id = current_admin.id
    tag_list = params[:item][:tag_name].split(',')
    if @item.save
      @item.save_tags(tag_list)
      redirect_to admin_item_path(@item.id)
    else
      @items = Item.all
      render :new
    end
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_items_path(item.id)
  end


  #投稿データのストロングパラメータ
  private
  def item_params
    params.require(:item).permit(:image, :name, :caption, :excluded_price, :admin_id, :is_status)
  end

end
