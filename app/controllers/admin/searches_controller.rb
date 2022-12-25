class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
   @model = params[:model]
   @content = params[:content]
   @method = params[:method]
   @items = Tag.search_items_for(@content, @method)
  end
  
end
