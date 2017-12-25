Rails.application.routes.draw do

  resources :locations, only: [:index, :show] do
    resources :stop_points, only: [:index, :show, :create]
  end
  resources :users, only: :show do
    resources :cars, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
