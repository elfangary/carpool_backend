Rails.application.routes.draw do
  
  resources :locations, only: [:index, :show]

  get '/trips/filtered_trips', to: 'trips#filter_by_day_and_location'
  resources :trips, only: [:index, :show, :create] do
    resources :stop_points, only: [:index]
  end

  resources :users, except: :index do
    resources :cars, only: [:index, :show]
  end
  post 'signup', to:'registrations#create'
  post 'login', to:'sessions#create'
end
