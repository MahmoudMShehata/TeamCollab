# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/dashboard', to: 'home#dashboard'

  root 'home#index'

  resources :tasks do
    member do
      post 'add_collaborator'
      get 'remove_collaborator'
      get 'delete_attachment'
    end
  end
  resources :task_pools do
    member do
      post 'add_task'
    end
  end
end
