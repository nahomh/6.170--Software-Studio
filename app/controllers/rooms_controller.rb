class RoomsController < ApplicationController
  before_filter :require_login, :only => [:show]
  def index
    @rooms = Room.order("id DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @rooms }
    end
  end

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
    print "yes!!"
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
        if  current_user.close_to_room(@room) < 1.0
          current_user.checkout(@room.id)
          if !@room.occupied
            @room.checkout
          end
          format.html { redirect_to @room, :notice => "Successfully checked room out" }
          format.js {}
        else
          format.html { redirect_to @room, :flash => {:error => "You are not close enough to the room"} }
          format.js {}
        end
        #else
        #  format.html { redirect_to @room, :flash => {:error => "You have already checked out this room." }}
        #  format.js {}
        #end
      end
    end
  end

  def refresh
    @room = Room.find(params[:room_id])
    respond_to do |format|
      format.js { render :partial => 'rooms/room', :locals => {:room => @room} }
      format.html
    end
  end 

  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @room }
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, :notice =>'Room was successfully created.' }
        format.json { render :json => @room, :status => :created, :location => @room }
      else
        format.html { render :action => "new" }
        format.json { render :json => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to @room, :notice => 'Room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.json { head :no_content }
    end
  end
end
