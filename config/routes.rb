Activate::Application.routes.draw do
  get "users/show"
  get "home/map"
  get "users/friends"

  resources "users" do
    put "set_location"
  end 

  get "home/index"
  match "set_location" => 'users#set_location'

  resources "rooms" do
    get 'checkout'
    get 'checkin'
    get 'refresh'
    put 'set_location'
  end

  get "sessions/create"

  match 'auth/:provider/callback' => 'sessions#create'
  match 'auth/failure' => redirect('/')
  match 'signout' => 'sessions#destroy', :as => :signout
  root :to => 'home#index'
end
