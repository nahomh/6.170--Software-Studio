class HomeController < ApplicationController
  helper_method :sort_column, :sort_direction
 #Requires: None
 #Loads the home page, and renders the status of different rooms.
  def index
    Room.return_busy
    if params[:whiteboard_available] == 'true' && params[:projector_available] == 'true'
      @rooms = Room.search(params[:search]).where(:projector_available => true, :whiteboard_available => true).order(sort_column + ' ' + sort_direction).paginate(:per_page => 10, :page => params[:page])
    elsif params[:whiteboard_available] == 'true'
      @rooms = Room.search(params[:search]).where(:whiteboard_available => true).order(sort_column + ' ' + sort_direction).paginate(:per_page => 10, :page => params[:page])
    elsif params[:projector_available] == 'true'
      @rooms = Room.search(params[:search]).where(:projector_available => true).order(sort_column + ' ' + sort_direction).paginate(:per_page => 10, :page => params[:page])
    else
      @rooms = Room.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 10, :page => params[:page])
    end
    if current_user
      @graph = graph
    end
    @map_info = @rooms.to_gmaps4rails do |room, marker|
      if room.occupied?
        marker.picture({
          :picture => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=U|FF0000|000000", 
          :width   => 32,
          :height  => 32
        })
      else
        marker.picture({
          :picture => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=A|32cd32|000000",
          :width   => 32,
          :height  => 32
        })
      end
    end
    @friends = []

    if current_user
      @friends = current_user.friends(graph).order("room_id ASC ")
    end
    respond_to do |format|
      format.json { render :json => @map_info }
      format.js { render :partial => "rooms/table", :locals => { :rooms => @rooms, :sort => sort_column, :order => sort_direction, :page => params[:page], :whiteboard => params[:whiteboard_available], :projector => params[:projector_available] } }
      format.html
    end
  end
  #Requires:None
  #sorts the columns of the rooms table.
  def sort_column
    Room.column_names.include?(params[:sort]) ?  params[:sort] : "room_number"
  end
  #Reuires:None
  #sorts the direction of the rooms table. 
  def sort_direction
    %w[asc desc].include?(params[:order]) ?  params[:order] : "asc"
  end
end
