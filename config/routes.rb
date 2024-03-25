Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'application#index'
  resources :goals
  resources :expenses
  resources :budgets
  devise_for :users, controllers: {
      registrations: 'users/registrations'
    }

  get 'plaid/new'
  post '/plaid/create_link_token'
  post '/plaid/exchange_public_token'
end
