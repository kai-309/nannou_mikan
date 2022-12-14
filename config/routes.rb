Rails.application.routes.draw do
  devise_for :users
# 顧客用(public)
# URL /customers/sign_in ...
  devise_for :customers,skip:[:passwords],controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

# 管理者用(admin)
  devise_for :admin,skip:[:registrations,:passwords],controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root :to =>"homes#top"
    resources :items,         only: [:index, :new, :show, :edit, :create, :update]
    resources :genres,        only: [:index, :edit, :create, :update]
    resources :customers,     only: [:index, :show, :edit, :update]
    resources :orders,        only: [:show, :update]
    resources :order_details, only: [:update]
    get '/search', to: 'searches#search'
  end

  scope module: :public do
    root :to =>"homes#top"
    get "homes/about"                => 'homes#about',            as: 'about'
    get "customers/unsubscribed"     => 'customers#check',        as: 'customers/check'
    get "cart_items/destroy_all"     => 'cart_items#destroy_all', as: 'cart_items/destroy_all'
    get "orders/check"               => 'orders#check',           as: 'orders/check'
    get "orders/complete"            => 'orders#complete',        as: 'orders/complete'
    get 'customers/my_page'          => 'customers#show',         as: 'mypage'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/infomation'     => 'customers#update'
    patch "customers/withdrawal"     => 'customers#withdrawal',   as: 'customers/withdrawal'

    resources :items,      only: [:index, :show]
    resources :items do
     resources :comments,  only: [:create, :destroy]
     resources :reviews
    end
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete "destroy_all" => "cart_items#destroy_all"
      end
    end

    resources :orders,     only: [:new, :create, :index, :show] do
      collection do
        post "check"
        get "complete"
      end
    end

    resources:addresses,   only: [:index, :create, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

