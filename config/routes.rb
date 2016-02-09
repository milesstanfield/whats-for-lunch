Rails.application.routes.draw do
  devise_for :users, skip: [:registerable, :discoverable]
  resources :restaurants, only: [:index, :new, :show, :create]
  root 'dashboard#index'
end
