Rails.application.routes.draw do

 devise_for :users
  root to: 'items#index'

 resources :items do
  resources :comments, only: :create
  resources :orders, only: [:create, :index]
  
  collection do
      get 'search'
  end
end

 resources :articles
 
 resources :categories, only:[:new]
 get '/category/:id', to: 'categories#search'

end