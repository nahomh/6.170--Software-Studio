class SessionsController < ApplicationController
  #Creates a new user authenticated session
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end
  #Destroys a user session
  def destroy
    reset_session
    redirect_to root_url
  end
end
