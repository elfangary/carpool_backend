Rails.application.routes.draw do

  #Signup and Login Routes
  post 'signup', to:'registrations#create'
  post 'login', to:'sessions#create'

  # User Routes
  get '/user', to: 'users#show';
  delete '/user/destroy', to: 'users#destroy';
  put '/user/update', to: 'users#update';
  
  #Car Routes
  resources :cars, only: [:index, :show]

  #Location Routes
  resources :locations, only: [:index, :show]

  resources :trips, only: [:index, :show, :create] do
    resources :stop_points, only: [:index]
  end

  #Filtered Trips Routes
  get '/trips/filtered_trips', to: 'trips#filter_by_day_and_location'

  #Driver Trips Tracking
  get 'driver/trips', to: 'trips#driverTripsTracking'
  #Hitch-Hiker Trips Tracking
  get '/hitch-hiker/trips', to: 'trips#hhTripsTracking'

  #Create hh Stop Point
  post '/hitch-hiking', to: 'hh_stop_points#create'

  #Notification Routes
  resources :notifications, except: [:destroy, :show]
end
