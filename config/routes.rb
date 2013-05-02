Activate::Application.routes.draw do
  get "users/show"

  resources "users"

  get "home/index"

  resources "rooms" do
    get 'checkout'
    get 'checkin'
    get 'refresh'
    put 'new_location'
  end

  get "sessions/create"

  match 'auth/:provider/callback' => 'sessions#create'
  match 'auth/failure' => redirect('/')
  match 'signout' => 'sessions#destroy', :as => :signout
  root :to => 'home#index'
end
