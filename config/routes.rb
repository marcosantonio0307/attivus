Rails.application.routes.draw do
  devise_for :clients
  devise_for :users
  root 'home#index'

  get '/budget' => 'home#budget'
  get '/news' => 'home#news'
  get '/offers' => 'home#offers'

  get 'admin/products/new' => 'admin#new_product'
  get 'admin/products' => 'admin#products'
  get 'admin/products/:id' => 'admin#show_product', as: :admin_product
  get 'admin/products/:id/edit' => 'admin#edit_product', as: :admin_edit_product
  get 'admin/orders/payment_pending' => 'admin#payment_pending'
  get 'admin/orders/send_pending' => 'admin#send_pending'
  get 'admin/orders/received_pending' => 'admin#received_pending'
  get 'admin/orders/finished' => 'admin#finished'
  get 'admin/orders/:id/show_order' => 'admin#show_order', as: :admin_orders_show_order
  get 'admin/orders/:id/confirm_payment' => 'admin#confirm_payment', as: :admin_orders_confirm_payment
  get 'admin/orders/:id/confirm_send' => 'admin#confirm_send', as: :admin_orders_confirm_send
  get 'admin/orders/:id/confirm_received' => 'admin#confirm_received', as: :admin_orders_confirm_received

  get 'orders/items/add/:id' => 'items#add', as: :add_order_item
  get 'orders/:id/checkout' => 'orders#checkout', as: :order_checkout
  get 'orders/orders_finish' => 'orders#orders_finish', as: :orders_finish
  get 'orders/:id/finish' => 'orders#finish', as: :finish_order
  get 'orders/:id/create' => 'orders#create'
  get 'orders/:id/myorder' => 'orders#myorder', as: :myorder
  put 'orders/:id/receipt' => 'orders#receipt', as: :orders_receipt

  resources :products, only:[:create, :update, :index, :show] do
  	resources :files, only:[:new, :create, :edit, :update, :destroy]
  end

  resources :orders do
  	resources :items
    resources :file
  end

  resources :contacts, only:[:new, :create]
  get 'contacts/budget' => 'contacts#budget'
  get 'contacts/professional' => 'contacts#professional'

  #routes for admin panel

  namespace :admin do
    resources :categories, only:[:index, :new, :create, :edit, :update]
    resources :contacts, only:[:index, :edit, :show]

    get 'budgets' => 'contacts#budgets', as: :contacts_budgets_received
    get 'budgets_sends' => 'contacts#budgets_sends', as: :contacts_budgets_sends
    get 'professional' => 'contacts#professional', as: :contacts_professional_received
    get 'professional_sends' => 'contacts#professional_sends', as: :contacts_professional_sends
  end
  
  resources :admin, only:[:index]
end
