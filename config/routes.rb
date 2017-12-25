Rails.application.routes.draw do
  resources :trips only: [:index, :show, :create] do
    resources :stop_points, only: [:index]
  end
  post '/stop_points', to: 'stop_points#create'

  resources :users, only: :show do
    resources :cars, only: [:index, :show]
  end

  resources :locations, only: [:index, :show]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
end
