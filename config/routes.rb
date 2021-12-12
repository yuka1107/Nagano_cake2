Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
  }

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }

  namespace :admin do
    root to: 'homes#top'
    resources :genres, except: [:destroy, :new, :show]
    resources :items, except: [:destroy]
    resources :customers, except: [:destroy, :new, :create]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  namespace :public do
    root to: 'homes#top'
    get "about" => 'homes#about'
    resources :items, only: [:index, :show]
    resources :customers, only: [:edit, :update]
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw'
    resources :cart_items
    delete 'cart_items' => 'cart_items#destroy_all'
    resources :orders, only: [:new, :index, :show]
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/thanks' => 'orders#thanks'
    resources :addresses, except: [:new, :show]
  end
  #publicのルートパス
  root to: 'public/homes#top'

end
