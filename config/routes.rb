# frozen_string_literal: true

Rails.application.routes.draw do
  get 'books/index'
  root to: 'top#top'
  devise_for :users
  get 'posts/search' => 'posts#search'
  get 'posts/other_users_posts' => 'posts#other_posts'

  resources :posts
  resources :languages

  resources :users
  get 'practice' => 'timers#practice'
  resources :timers, only: %i[show new index create update]
end
