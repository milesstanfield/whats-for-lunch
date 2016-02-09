Rails.application.routes.draw do
  devise_for :users, skip: [:registerable, :discoverable]
  root 'dashboard#index'
end
