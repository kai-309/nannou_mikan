class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_search

   def set_search
     @search = Item.ransack(params[:q])
     @search_items = @search.result
   end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :post_code, :address, :phone_number])
  end
end
