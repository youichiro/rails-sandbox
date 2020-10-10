Rails.application.routes.draw do
  namespace :api do
    resources :tasks, only: [:index, :show, :create, :update, :destroy]
  end
end
