Rails.application.routes.draw do
  devise_for :users, controllers: {
        registration: 'users/registrations'
      }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'application#index'

  get 'plaid/new'

end
