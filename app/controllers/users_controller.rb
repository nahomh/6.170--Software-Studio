class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def set_location
	current_user.update_location(params[:longitude], params[:latitude])
    respond_to do |format|
      format.js {render :nothing => true }
    end
  end 
end
