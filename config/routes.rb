Rails.application.routes.draw do

  resources :reviews
  devise_for :users
  root "movies#index"

  resources :movies

end
