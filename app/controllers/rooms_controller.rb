class RoomsController < ApplicationController
  def index
    @rooms = Room.all

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
    end
  end

  def checkout
    @room = Room.find(params[:room_id])
    @room.checkout(current_user.id)
    respond_to do |format|
      format.html { redirect_to @room, :notice => "Successfully checked room out" }
      format.js {}
    end
  end

  def checkin
    @room = Room.find(params[:room_id])
    @room.checkin
    respond_to do |format|
      format.html { redirect_to @room, :notice => "Successfully checked room back in" }
      format.js {}
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
