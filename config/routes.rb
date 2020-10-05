Rails.application.routes.draw do
  resources :votes
  resources :users
  resources :sessions
  resources :articles, only: %i[index create update delete show edit new]
  root to: 'articles#index'
end
