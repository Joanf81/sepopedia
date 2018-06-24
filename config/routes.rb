Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'devise/user_registrations' }

  root to: "home#index"

  resources :users, only: [:show] do
  	get "my_profile" => "users#my_profile", on: :collection
  end
end
