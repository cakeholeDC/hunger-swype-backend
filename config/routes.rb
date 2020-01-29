Rails.application.routes.draw do
  # resources :dish_courses
  # resources :dish_cuisines
  # resources :dish_diets
  # resources :users
  # resources :favorites
  # resources :courses
  # resources :cuisines
  # resources :diets
  resources :restaurants
  resources :recipes
  resources :dishes, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
