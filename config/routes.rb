Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  
  root 'recipes#home'

  resources :foods, except: [:update]
  resources :recipes, except: [:update]
  get '/public_recipies', to: 'recipes#public_recipies'

  get '/shopping_list', to: 'shopping_list#index'

  resources :recipes do
    resources :recipe_foods
  end
  resources :users
  put '/recipes/:id/toggle_public', to: 'recipes#toggle_public', as: 'toggle_recipe_public'

end
