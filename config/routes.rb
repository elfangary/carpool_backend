Rails.application.routes.draw do
  resources :trips, only: [:index, :show, :create]
  resources :users, only: :show do
    resources :cars, only: [:index, :show]
  end
end
