Rails.application.routes.draw do
  devise_for :users, skip: :registerable
  root 'home#index'
end
