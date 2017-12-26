Rails.application.routes.draw do
  
  resources :locations, only: [:index, :show]

  resources :trips, only: [:index, :show, :create] do
    resources :stop_points, only: [:index]
  end

  resources :users, only: :show do
    resources :cars, only: [:index, :show]
  end
end
