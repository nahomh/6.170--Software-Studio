class HomeController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
  	@rooms = Room.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 10, :page => params[:page])
    if current_user
      @graph = graph
    end
    @json = @rooms.to_gmaps4rails do |room, marker|
      if room.occupied?
      marker.picture({
        :picture => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=O|FF0000|000000", # up to you to pass the proper parameters in the url, I guess with a method from device
        :width   => 32,
        :height  => 32
   })
      else
      marker.picture({
     :picture => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=A|32cd32|000000", # up to you to pass the proper parameters in the url, I guess with a method from device
     :width   => 32,
     :height  => 32
   })
      end
    end
    @friends = []

    if current_user
      @friends = current_user.friends(graph).order("room_id ASC ")
   	  print @friends
    end
    respond_to do |format|
      format.js { render :partial => "rooms/table", :locals => { :rooms => @rooms, :sort => sort_column, :order => sort_direction, :page => params[:page] } }
      format.html
    end
  end
  def sort_column
    Room.column_names.include?(params[:sort]) ?  params[:sort] : "room_number"
  end

  def sort_direction
    %w[asc desc].include?(params[:order]) ?  params[:order] : "asc"
  end
end
