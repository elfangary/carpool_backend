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

  #Filterd Trips
  get '/trips/filtered_trips', to: 'filter_trips#index'

  #Driver Trips Tracking
  get 'driver/trips', to: 'driver_trips_tracking#index'
  
  #Hitch-Hiker Trips Tracking
  get 'hitch-hiker/trips', to: 'hh_trips_tracking#index'

  resources :trips, only: [:index, :show, :create] do
    resources :stop_points, only: [:index]
  end

  #Create New HH Stop Point
  post '/hitch-hiking', to: 'hh_stop_points#create'

  #Update Hh Stop Point
  patch '/hitch-hicker-point-update', to: 'change_hh_stop_point_status#update'

  #Get User Rating
  get '/rating', to: 'user_rating#index'

  #Rate Another User
  patch '/add_rate', to: 'user_rating#update'

end
