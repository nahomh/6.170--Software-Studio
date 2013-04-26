class HomeController < ApplicationController
  def index
  	@rooms = Room.all
    @json = @rooms.to_gmaps4rails
  end
end