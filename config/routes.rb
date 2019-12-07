Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/usuarios', to: 'users#create'
  post '/sesiones', to: 'users#auth'

  get  '/productos', to: 'products#index'
  get  '/productos/:code', to: 'products#show'
  get  '/productos/:code/items', to: 'products#show_items'
  post '/productos/:code/items', to: 'products#add_items'
end
