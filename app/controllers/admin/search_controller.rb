class Admin::SearchController < ApplicationController
  before_action :authenticate_admin!
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'admin'
      @records = Admin.search_for(@content, @method)
    elsif @model == 'item'
      @records = Item.search_for(@content, @method)
    elsif @model == 'tag'
      @records = Tag.search_items_for(@content, @method)
    end
  end
end
