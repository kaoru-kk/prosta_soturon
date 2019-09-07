Rails.application.routes.draw do
  root to: "top#top"
  devise_for :users
  resources :users
  resources :posts
  resources :languages
end
