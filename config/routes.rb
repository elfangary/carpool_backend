Rails.application.routes.draw do
  
  resources :locations, only: [:index, :show]

  post '/hitch-hiking', to: 'hh_stop_points#create'

  get '/trips/filtered_trips', to: 'trips#filter_by_day_and_location'

  #Driver Trips Tracking
  get 'driver/trips', to: 'trips#driverTripsTracking'
  #Hitch-Hiker Trips Tracking
  get '/hitch-hiker/trips', to: 'trips#hhTripsTracking'

  resources :trips, only: [:index, :show, :create] do
    resources :stop_points, only: [:index]
  end
  resources :users, except: :index 
  
  resources :users, only: :show do
    resources :cars, only: [:index, :show]
  end
  post 'signup', to:'registrations#create'
  post 'login', to:'sessions#create'
end
