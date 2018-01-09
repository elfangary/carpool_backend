Rails.application.routes.draw do

  #Admin Signup and Login Routes
  namespace :admin do 
    post 'signup', to: 'regestration#create';
    post 'login', to: 'login#create';
  end

  #User Signup and Login Routes
  post 'signup', to:'registrations#create'
  post 'login', to:'sessions#create'

  # User Routes
  get '/user', to: 'users#show';
  delete '/user/destroy', to: 'users#destroy';
  put '/user/update', to: 'users#update';
  patch '/user/update', to: 'users#update';

  #Car Routes
  resources :cars, except: :update

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


  #Create hh Stop Point
  post '/hitch-hiking', to: 'hh_stop_points#create'

  #Create a new payment
  resources :charges, only: [:create]
  resources :add_charged_points, only: [:create]

  #Notification Routes
  resources :notifications, except: [:destroy, :create]
end
