Rails.application.routes.draw do
  namespace :api do 
    resources :prospects
    resources :companies, only: [:index, :create, :update, :destroy]
  end

  root 'api/prospects#index'
end
