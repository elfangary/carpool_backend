Rails.application.routes.draw do
  
  resources :locations, only: [:index, :show]

  get '/trips/filtered_trips', to: 'trips#filter_by_day_and_location'
  resources :trips, only: [:index, :show, :create] do
    resources :stop_points, only: [:index]
  end

  resources :users, only: :show do
    resources :cars, only: [:index, :show]
  end
end
