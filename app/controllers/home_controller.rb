class HomeController < ApplicationController
  def index
  	@rooms = Room.order("id DESC")
    @json = @rooms.to_gmaps4rails
    @friends = []
    if current_user
      @friends = current_user.friends(graph)
    end
  end
end
