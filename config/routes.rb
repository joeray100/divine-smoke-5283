Rails.application.routes.draw do
  resources :gardens, only: :show
  resources :plots, only: :index
  delete "/plots/:plot_id/plants/:plant_id", to: 'plot_plants#destroy'
end
