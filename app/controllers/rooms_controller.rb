class RoomsController < ApplicationController
  before_filter :require_login, :only => [:show]
  def show
    @room = Room.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json  => @room }
      format.js {}
    end
  end

  def new_location
    current_user.update_location(params[:longitude], params[:latitude])
    @room = Room.first
    respond_to do |format|
      format.js {render :nothing => true }
    end
  end

  def checkout
    @room = Room.find(params[:room_id])
    respond_to do |format|
      if @room.users.include?(current_user) 
        current_user.checkin
        if @room.users.size == 0
          @room.checkin
        end
        format.html { redirect_to @room, :notice => "Successfully checked room back in" }
        format.js {}
      else
        if current_user.close_to_room(@room) <.5
          old_room = current_user.room
          current_user.checkout(@room.id)
          if old_room && old_room.users.size == 0
            old_room.checkin
          end
          if !@room.occupied
            @room.checkout
          end
          format.html { redirect_to @room, :notice => "Successfully checked room out" }
          format.js {}
        else
          format.html { redirect_to @room, :flash => {:error => "You are not close enough to the room"} }
          format.js {}
        end
      end
    end
  end
  
  def refresh
    @room = Room.find(params[:room_id])
    respond_to do |format|
      format.json { render :json => @room }
      format.html
    end
  end 
end
