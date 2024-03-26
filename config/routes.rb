Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'application#index'
  devise_for :users, controllers: {
      registrations: 'users/registrations'
    }
  resources :goals
  resources :expenses
  resources :budgets

  get '/transactions', to: 'transactions#index'
  get '/spending', to: 'transactions#spending'
  get '/plaid/new'
  post '/plaid/create_link_token'
  post '/plaid/exchange_public_token'
  get '/plaid/accounts'
end
