Rails.application.routes.draw do
  devise_for :clients
  devise_for :users
  root 'home#index'

  get '/budget' => 'home#budget'
  get '/news' => 'home#news'

  get 'admin/products/new' => 'admin#new_product'
  get 'admin/products' => 'admin#products'
  get 'admin/products/:id' => 'admin#show_product', as: :admin_product
  get 'admin/products/:id/edit' => 'admin#edit_product', as: :admin_edit_product

  get 'orders/items/add/:id' => 'items#add', as: :add_order_item
  get 'orders/:id/checkout' => 'orders#checkout', as: :order_checkout
  get 'orders/orders_finish' => 'orders#orders_finish', as: :orders_finish
  get 'orders/:id/finish' => 'finish#orders', as: :finish_order
  get 'orders/:id/create' => 'orders#create'

  resources :products, only:[:create, :update, :index, :show] do
  	resources :files, only:[:new, :create, :edit, :update, :destroy]
  end

  resources :orders do
  	resources :items
  end

  resources :admin, only:[:index]
end
