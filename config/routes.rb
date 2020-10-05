Rails.application.routes.draw do
  resources :votes, only: %i[update delete]
  resources :users, only: %i[create update delete show edit new]
  resources :sessions
  resources :articles, only: %i[index create update delete show edit new]
  root to: 'articles#index'
end
