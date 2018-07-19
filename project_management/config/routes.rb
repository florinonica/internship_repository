Rails.application.routes.draw do
  devise_for :users
  resources :users, except: :create
  resources :projects
  post 'create_user' => 'users#create', as: :create_user   
  root 'welcome#index'
end
