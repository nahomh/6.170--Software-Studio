class HomeController < ApplicationController
  def index
  	@rooms = Room.order("id DESC")
    @json = @rooms.to_gmaps4rails
  end
end