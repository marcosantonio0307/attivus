Rails.application.routes.draw do
  root 'home#index'

  get '/budget' => 'home#budget'
  get '/news' => 'home#news'
end
