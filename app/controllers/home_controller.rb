class HomeController < ApplicationController
  def index
  	@rooms = Room.all
    @json = @rooms.to_gmaps4rails do |room, marker|
    	marker.infowindow render_to_string(:partial => "/home/infowindow", :locals => { :room => room})
	    marker.title "#{room.name}"
	    marker.json({ :description => room.description})
	    marker.picture({:picture => "http://mapicons.nicolasmollet.com/     wp-content/uploads/mapicons/shape-default/color-3875d7/shapeco     lor-color/shadow-1/border-dark/symbolstyle-contrast/symbolshad     owstyle-dark/gradient-iphone/information.png",
	                    :width => 32,
	                    :height => 32})
  	end
  end
end