Rails.application.routes.draw do

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
    resources :cart_items, only: [:create, :index, :update]
    resources :orders, only: [:new, :index, :show]
    resources :addresses, except: [:new, :show]
  end

end
