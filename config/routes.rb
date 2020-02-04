Rails.application.routes.draw do
  # resources :dish_courses
  # resources :dish_cuisines
  # resources :dish_diets
  # resources :users
  # resources :favorites
  resources :courses, only: [:index]
  resources :cuisines, only: [:index]
  resources :diets, only: [:index]
  # resources :restaurants
  resources :recipes, only: [:show]
  resources :dishes, only: [:index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/get-matches/', to: 'dishes#match'
  get '/match/recipe/:id', to: 'recipes#show'
end
