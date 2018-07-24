Rails.application.routes.draw do
  devise_for :users
  resources :users, except: :create
  resources :projects do
  	resources :tickets
  	resources :comments
  end
  post 'create_user' => 'users#create', as: :create_user   
  patch 'projects/:id/add_client' => 'projects#add_client'
  patch 'projects/:id/add_project_manager' => 'projects#add_project_manager'
  patch 'projects/:id/assign_dev' => 'tickets#assign_dev'
  patch 'projects/:id/add_dev' => 'projects#add_dev'
  patch 'projects/:id/add_tester' => 'projects#add_tester'
  get 'projects/:id/dashboard' => 'projects#dashboard', :as => :dashboard
  resources :clients, param: :client_id
  root 'welcome#index'
end
