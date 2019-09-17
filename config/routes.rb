Rails.application.routes.draw do
  root to: "top#top"
  devise_for :users
  get "posts/search" => "posts#search"

  resources :posts
  resources :languages

  resources :users
  resources :timers,only: [:show, :new,:create, :update ]


end
