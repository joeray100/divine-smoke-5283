Rails.application.routes.draw do
  resources :gardens, only: :show
  resources :plots, only: :index
end
