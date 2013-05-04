class ApplicationController < ActionController::Base
  protect_from_forgery
  private
  def require_login
    unless current_user
      redirect_to root_path, :flash => {:error => "You must be logged in to do this"}
    end
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def graph
    @graph = Koala::Facebook::API.new(current_user.oauth_token)
  end
  helper_method :current_user
end
