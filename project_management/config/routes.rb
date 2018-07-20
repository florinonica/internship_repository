Rails.application.routes.draw do
  devise_for :users
  resources :users, except: :create
  resources :projects
  post 'create_user' => 'users#create', as: :create_user   
  patch 'projects/:id/add_client' => 'projects#add_client'
  patch 'projects/:id/add_project_manager' => 'projects#add_project_manager'
  resources :clients, param: :client_id
  root 'welcome#index'
end
