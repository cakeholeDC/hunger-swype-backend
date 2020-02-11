# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :favorites, only: [:create, :update]
  resources :user_diets, only: [:create]
  # resources :dish_courses
  # resources :dish_cuisines
  # resources :dish_diets
  
  resources :users, only: [:show, :create, :update]
  
  # resources :users do
  #   member do
  #     get :confirm_email
  #   end
  # end
  get '/users/confirm_email/:token', to: 'users#confirm_email'


  resources :favorites, only: [:create, :update]
  resources :courses, only: [:index]
  resources :cuisines, only: [:index]
  resources :diets, only: [:index]
  resources :recipes, only: [:show]
  resources :dishes, only: [:index, :create]
  # resources :restaurants


  post '/get-matches/', to: 'dishes#match'
  get '/match/recipe/:id', to: 'recipes#show'

  get '/profile', to: 'users#profile'
  post '/preferences', to: 'user_diets#create'

  namespace :api do
    namespace :v1 do
      post '/login', to: 'auth#create'
      get '/login', to: 'dishes#index'
    end
  end
  
end
