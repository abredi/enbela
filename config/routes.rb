Rails.application.routes.draw do
  resources :votes, only: %i[update destroy]
  resources :users, only: %i[create update show edit new]
  resources :sessions, only: %i[create new destroy]
  resources :articles, only: %i[index create update show edit new]
  root to: 'articles#index'
end
