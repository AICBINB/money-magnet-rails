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

  # Ask ChatGPT for financial advice. The request body should look like this:
  # {
  #   text: "A paragraph containing information about the budget and the income, expenses, and goals of the user(s)"
  # }
  post "/advice", to: "advice#advise"
  
end
