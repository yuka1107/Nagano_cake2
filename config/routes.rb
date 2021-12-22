Rails.application.routes.draw do

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only:[:index, :show]
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: "withdraw_customers"
    resource :customers, only:[:show, :edit, :update]
    resources :addresses
    post "orders/confirm" => "orders#confirm", as: "confirm_orders"
    get "orders/thanks" => "orders#thanks"
    resources :orders, only:[:new, :create, :index, :show]
    delete "cart_items/destroy_all" => "cart_items#destroy_all", as: "destroy_all_cart_items"
    resources :cart_items, only:[:create, :index, :update, :destroy]
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
    root to: '/admin/homes#top'
    resources :orders, only:[:show, :update]
    resources :customers,except:[:new,:create,:destroy]
    resources :genres
    resources :items
    resources :order_details, only:[:update]
  end

end