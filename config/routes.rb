Rails.application.routes.draw do
  
  resources :locations, only: [:index, :show]

  get '/trips/filtered_trips', to: 'trips#filter_by_day_and_location'

  #Driver Trips Tracking
  get 'users/:id/driver/trips', to: 'trips#driverTripsTracking'
  #Hitch-Hiker Trips Tracking
  get 'users/:id/hitch-hiker/trips', to: 'trips#hhTripsTracking'

  resources :trips, only: [:index, :show, :create] do
    resources :stop_points, only: [:index]
  end

  post '/hitch-hiking', to: 'hh_stop_points#create'

  resources :users, only: :show do
    resources :cars, only: [:index, :show]
  end
end
