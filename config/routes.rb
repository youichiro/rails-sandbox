Rails.application.routes.draw do
  namespace :api do
    resources :tasks, only: [:index, :show, :create, :update, :destroy]
    resource :user, only: [:show, :create]
    resource :session, only: [:create, :destroy]
  end
end
