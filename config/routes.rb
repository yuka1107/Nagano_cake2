Rails.application.routes.draw do

  devise_for :admins
  devise_for :customers

  namespace :admin do
    resources :homes
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items
    resources :customers
  end

end
