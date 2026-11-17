Rails.application.routes.draw do
  resources :movies, except: :show
  resources :categories, except: :show

  get "up" => "rails/health#show", as: :rails_health_check

  root "movies#index"
end
