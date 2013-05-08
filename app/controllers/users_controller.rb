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

  def friends
    @friends = []
    if current_user
      @friends = current_user.friends(graph).order("room_id ASC ")
    end
    respond_to do |format|
      format.js { render :partial => "friends", :locals => { :friends => @friends } }
    end
  end
end
