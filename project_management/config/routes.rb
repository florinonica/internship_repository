Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, except: :create
  resources :projects do
  	resources :tickets do
  	 resources :comments
    end
  end
  post 'create_user' => 'users#create', as: :create_user   
  patch 'projects/:id/add_client' => 'projects#add_client'
  patch 'projects/:id/add_project_manager' => 'projects#add_project_manager'
  patch 'projects/:id/assign_dev' => 'tickets#assign_dev'
  patch 'projects/:id/add_dev' => 'projects#add_dev'
  patch 'projects/:id/add_tester' => 'projects#add_tester'
  patch 'projects/:id/add_employees' => 'projects#add_employees'
  get 'projects/:id/dashboard' => 'projects#dashboard', :as => :dashboard
  get 'projects/:id/team' => 'projects#team', :as => :team
  resources :clients, param: :client_id
  resources :tickets do
    resources :comments
  end
  root 'welcome#index'

end
