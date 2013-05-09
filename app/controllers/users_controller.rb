class UsersController < ApplicationController
  #Passes the current user to the home page.
  def show
    @user = User.find(params[:id])
  end
 #Enables the current user to set and save their current location.
 #Params:latitiude, longtiude
  def set_location
	current_user.update_location(params[:longitude], params[:latitude])
    respond_to do |format|
      format.js {render :nothing => true }
    end
  end 
 #Creates a list of friends on MITSpaces and orders them by the room their currently studying in. Params:none
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
