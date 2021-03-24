Rails.application.routes.draw do
  devise_for :users
  get 'home/top'
  root to: "home#top"
  resources :outputs, only: [:index, :new, :create, :show, :edit, :update]
end