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
  patch 'projects/:id/add_files' => 'projects#add_files'
  get 'projects/:id/remove_client' => 'projects#remove_client'
  get 'projects/:id/remove_employee' => 'projects#remove_employee'
  patch 'tickets/:id/change_status' => 'tickets#change_status', :as => :change_status
  patch 'tickets/:id/undo' => 'tickets#undo', :as => :undo
  patch 'tickets/:id/add_files' => 'tickets#add_files'
  get 'projects/:id/dashboard' => 'projects#dashboard', :as => :dashboard
  get 'projects/:id/files' => 'projects#files', :as => :files
  get 'projects/:id/team' => 'projects#team', :as => :team
  get 'projects/:id/clients' => 'projects#clients', :as => :clients
  get 'tickets/:id/subtasks' => 'tickets#subtasks', :as => :subtasks
  get 'tickets/:id/bugs' => 'tickets#bugs', :as => :bugs
  get 'tickets/:id/comments' => 'tickets#comments', :as => :comments
  get 'tickets/:id/files' => 'tickets#files', :as => :ticket_files
  get 'users/type' => 'users#custom_index', :as => :type
  get 'users/:id/remove_role' => 'users#remove_role'
  resources :clients, param: :client_id
  resources :attachments
  resources :tickets do
    resources :comments
  end
  root 'welcome#index'

end
