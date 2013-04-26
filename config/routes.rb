Activate::Application.routes.draw do
  get "home/index"

  resources "rooms" do
    put 'checkout'
    put 'checkin'
  end

  get "sessions/create"

  match 'auth/:provider/callback' => 'sessions#create'
  match 'auth/failure' => redirect('/')
  match 'signout' => 'sessions#destroy', :as => :signout
  root :to => 'home#index'
end
