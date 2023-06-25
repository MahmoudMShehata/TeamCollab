Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  get '/dashboard', to: 'home#dashboard'
  root "home#index"
end
