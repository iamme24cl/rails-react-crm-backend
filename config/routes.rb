Rails.application.routes.draw do
  namespace :api do
    get '/login' => 'sessions#check_if_logged_in'
    post '/login' => 'sessions#login'
    delete '/login/:id' => 'sessions#destroy'
    
    resources :prospects
    resources :companies, only: [:index, :create, :update, :destroy]
  end

  root 'api/sessions#check_if_logged_in'
end
