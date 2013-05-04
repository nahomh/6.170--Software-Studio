class HomeController < ApplicationController
  def index
  	@rooms = Room.order("id DESC")
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

    print "wtfwtfwtf"
    if current_user
      @friends = current_user.friends(graph).order("room_id DESC ")
   	  print @friends
    end
  end
end
