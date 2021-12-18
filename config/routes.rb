Rails.application.routes.draw do

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :items, only:[:index, :show]
    resource :customers, only:[:show, :edit, :update]
    post "customers/unsubscribe" => "customers#unsubscribe", as: "unsubscribe_customers"
    patch "customers/withdraw" => "customers#withdraw", as: "withdraw_customers"
    resources :addresses
    post "orders/confirm" => "orders#confirm", as: "confirm_orders"
    get "orders/thanks" => "orders#thanks", as: "thanks_orders"
    post "orders/determine" => "orders#determine", as: "determine_orders"
    resources :orders, only:[:new, :index, :show]
    delete "cart_items/destroy_all" => "cart_items#destroy_all", as: "destroy_all_cart_items"
    resources :cart_items, only:[:index, :update, :destroy, :create]
  end

  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
  }

  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  namespace :admin do
    root to: "/admin/homes#top"
   resources :orders, only: [:show, :update]
   resources :customers
   resources :genres
   resources :items
   resources :order_details, only: [:update]
  end

end