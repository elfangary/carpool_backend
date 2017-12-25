Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :trips, only: [:index, :show, :create
  resources :users, only: :show do
    resources :cars, only: [:index, :show]
  end
end
