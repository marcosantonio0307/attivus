Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get '/budget' => 'home#budget'
  get '/news' => 'home#news'

  get 'admin/products/new' => 'admin#new_product'
  get 'admin/products' => 'admin#products'
  get 'admin/products/:id' => 'admin#show_product', as: :admin_product
  get 'admin/products/:id/edit' => 'admin#edit_product', as: :admin_edit_product

  resources :products, only:[:create, :update, :index, :show]
  resources :admin, only:[:index]
end
