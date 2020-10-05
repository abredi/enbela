Rails.application.routes.draw do
  resources :sessions
  resources :users
  resources :articles, only: %i[index create update delete show edit new]
  root to: 'articles#index'
end
