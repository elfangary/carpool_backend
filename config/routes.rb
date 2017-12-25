Rails.application.routes.draw do

  resources :locations, only: [:index, :show]
  resources :stop_points, only: [:index, :show, :create]
  resources :users, only: :show
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
