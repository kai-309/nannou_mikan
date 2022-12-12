Rails.application.routes.draw do
# 顧客用(public)
# URL /customers/sign_in ...
#不要なルーティング(passwords)を削除
devise_for :customers,skip:[:passwords],controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用(admin)
# URL /admin/sign_in ...
#不要なルーティング(registrations, passwords)を削除
devise_for :admin,skip:[:registrations,:passwords],controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    root :to =>"homes#top"
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
