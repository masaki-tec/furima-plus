Rails.application.routes.draw do

 devise_for :users
  root to: 'items#index'

 resources :items do
  resources :orders, only: [:create, :index]
end
 resources :articles
 
 resources :categories, only:[:new]
 get '/category/:id', to: 'categories#search'

end