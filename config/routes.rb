Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get '/budget' => 'home#budget'
  get '/news' => 'home#news'

  resources :products, only:[:show]
end
