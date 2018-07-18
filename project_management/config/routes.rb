Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  resources :users, except: :create
  get 'create_user' => 'users#create', as: :create_user   
  root 'welcome#index'
end
