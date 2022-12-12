Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
#不要なルーティング(passwords)を削除
devise_for :customers,skip:[:passwords],controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
#不要なルーティング(registrations, passwords)を削除
devise_for :admin,skip:[:registrations,:passwords],controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'search' => 'homes#search', as: 'search'
    get 'customers/:customer_id/orders' => 'orders#index', as: 'customer_orders'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
