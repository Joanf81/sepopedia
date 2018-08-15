Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'devise/user_registrations' }

  root to: "home#index"

  get "webmaster" => "webmasters#webmaster"
  get "my_profile" => "users#my_profile"

  resources :users, only: [:show] do 
  	put :make_webmaster, to: "webmasters#make_webmaster", on: :member
  	put :renounce_webmaster, to: "webmasters#renounce_webmaster", on: :member
  	delete :delete_user, to: "webmasters#delete_user", on: :member
  end

  resources :articles, controller: "articles/articles" do
    get :editions, on: :member
    get "show_edition/:id_edition", on: :member, action: :show_edition
    put "restore/:id_edition", on: :member, action: :restore
  end
end
