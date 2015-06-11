Rails.application.routes.draw do
  root 'movies#index'

  devise_for :users
  resources :movies do
    collection do
      get 'search'
    end

    resources :reviews, except: [:index, :show]
  end
end
