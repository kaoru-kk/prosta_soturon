Rails.application.routes.draw do
  root to: "top#top"
  devise_for :users
  resources :posts
  resources :languages

  resources :users do
      resources :timers,only: [:show, :new,:create, :update ]
  end
end
