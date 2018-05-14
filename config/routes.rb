Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'devise/user_registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # FileUploader:
  mount Uploader::Engine => '/uploader'

  root to: "home#index"
end
