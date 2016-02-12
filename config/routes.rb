Rails.application.routes.draw do
  devise_for :users, skip: [:registerable, :discoverable]
  resources :restaurants
  post '/restaurants/update', to: 'restaurants#update', defaults: {format: 'js'}
  root 'home#index'
end
