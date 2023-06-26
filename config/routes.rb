Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  get '/dashboard', to: 'home#dashboard'
  
  root "home#index"
  
  resources :tasks
  resources :task_pools
end
