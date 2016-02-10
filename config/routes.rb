Rails.application.routes.draw do
  devise_for :users, skip: [:registerable, :discoverable]
  resources :restaurants
  root 'dashboard#index'
end
