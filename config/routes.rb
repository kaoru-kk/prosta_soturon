Rails.application.routes.draw do
  get 'books/index'
  root to: "top#top"
  devise_for :users
  get "posts/search" => "posts#search"

  resources :posts
  resources :languages

  resources :users
  get "practice" => "timers#practice"
  resources :timers,only: [:show, :new, :index,:create, :update ]


end
