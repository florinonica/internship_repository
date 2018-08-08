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
  get 'projects/:id/remove_client' => 'projects#remove_client'
  get 'projects/:id/remove_employee' => 'projects#remove_employee'
  patch 'tickets/:id/change_status' => 'tickets#change_status', :as => :change_status
  get 'projects/:id/dashboard' => 'projects#dashboard', :as => :dashboard
  get 'projects/:id/files' => 'projects#files', :as => :files
  get 'projects/:id/team' => 'projects#team', :as => :team
  get 'users/type' => 'users#custom_index', :as => :type
  get 'users/:id/remove_role' => 'users#remove_role'
  resources :clients, param: :client_id
  resources :attachments
  resources :tickets do
    resources :comments
  end
  root 'welcome#index'

end
